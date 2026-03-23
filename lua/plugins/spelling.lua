---@type LazySpec
return {
  {
    "davidmh/cspell.nvim",
    lazy = true,
    cond = function()
      local rooter = require "astrocore.rooter"
      local astro_root = rooter.detect(0, false, {
        detector = { { ".cspell.json" } },
      })[1]
      return astro_root ~= nil
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      if require("astrocore").is_available "cspell.nvim" then
        opts.sources = vim.list_extend(opts.sources or {}, {
          require("cspell.diagnostics"),
          require("cspell.code_actions"),
        })
      end
    end,
  },
}
