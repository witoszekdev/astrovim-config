-- nvim-treesitter master pin shadows core's `set-lang-from-info-string!`
-- with a handler that assumes `match[id]` is a single TSNode. On nvim 0.12 it
-- is always a list, so render-markdown crashes in markdown injections.
-- Re-register the directive list-aware. AstroNvim's treesitter spec is untouched.
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  init = function()
    require("vim.treesitter.query").add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
      local node = match[pred[2]]
      if type(node) == "table" then node = node[1] end
      if not node then return end
      local alias = vim.treesitter.get_node_text(node, bufnr):lower()
      metadata["injection.language"] = vim.filetype.match { filename = "a." .. alias } or alias
    end, { force = true, all = true })
  end,
}
