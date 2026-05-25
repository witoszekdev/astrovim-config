-- nvim-treesitter master is archived and its predicates/directives assume
-- `match[id]` is a single TSNode. On nvim 0.12 it is always a list[TSNode],
-- so every directive that calls `get_node_text(node, ...)` crashes with
-- `attempt to call method 'range' (a nil value)`. Re-register list-aware
-- wrappers AFTER nvim-treesitter loads so our overrides win.
local function first_node(n)
  if type(n) == "table" then return n[1] end
  return n
end

local function patch_predicates()
  local query = require "vim.treesitter.query"
  local opts = { force = true, all = true }

  local html_script_type_languages = {
    ["importmap"] = "json",
    ["module"] = "javascript",
    ["application/ecmascript"] = "javascript",
    ["text/ecmascript"] = "javascript",
  }
  local non_filetype_aliases = {
    ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript",
  }
  local function alias_to_parser(a)
    return vim.filetype.match { filename = "a." .. a } or non_filetype_aliases[a] or a
  end

  query.add_predicate("nth?", function(match, _, _, pred)
    local node = first_node(match[pred[2]])
    local n = tonumber(pred[3])
    if node and node:parent() and node:parent():named_child_count() > n then
      return node:parent():named_child(n) == node
    end
    return false
  end, opts)

  query.add_predicate("is?", function(match, _, bufnr, pred)
    local locals = require "nvim-treesitter.locals"
    local node = first_node(match[pred[2]])
    local types = { unpack(pred, 3) }
    if not node then return true end
    local _, _, kind = locals.find_definition(node, bufnr)
    return vim.tbl_contains(types, kind)
  end, opts)

  query.add_predicate("kind-eq?", function(match, _, _, pred)
    local node = first_node(match[pred[2]])
    local types = { unpack(pred, 3) }
    if not node then return true end
    return vim.tbl_contains(types, node:type())
  end, opts)

  query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
    local node = first_node(match[pred[2]])
    if not node then return end
    local val = vim.treesitter.get_node_text(node, bufnr)
    local configured = html_script_type_languages[val]
    if configured then
      metadata["injection.language"] = configured
    else
      local parts = vim.split(val, "/", {})
      metadata["injection.language"] = parts[#parts]
    end
  end, opts)

  query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = first_node(match[pred[2]])
    if not node then return end
    local alias = vim.treesitter.get_node_text(node, bufnr):lower()
    metadata["injection.language"] = alias_to_parser(alias)
  end, opts)

  query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = first_node(match[id])
    if not node then return end
    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
    if not metadata[id] then metadata[id] = {} end
    metadata[id].text = string.lower(text)
  end, opts)
end

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(args)
        if args.data == "nvim-treesitter" then
          patch_predicates()
          return true
        end
      end,
    })
  end,
}
