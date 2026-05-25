---@type LazySpec
return {
  "sigmasd/deno-nvim",
  opts = function(_, opts)
    opts.server = opts.server or {}
    opts.server.single_file_support = false
    opts.server.root_dir = function(arg)
      local fname = type(arg) == "number" and vim.api.nvim_buf_get_name(arg) or arg
      if type(fname) ~= "string" or fname == "" then return nil end
      if fname:find("/node_modules/", 1, true) then return nil end
      local dir = vim.fn.fnamemodify(fname, ":h")
      local found = vim.fs.find({ "deno.json", "deno.jsonc" }, {
        upward = true,
        path = dir,
        stop = vim.uv.os_homedir(),
      })[1]
      if not found then return nil end
      if found:find("/node_modules/", 1, true) then return nil end
      return vim.fn.fnamemodify(found, ":h")
    end
  end,
}
