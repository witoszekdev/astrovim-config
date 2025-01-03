local rooter = require "astrocore.rooter"

---@type LazySpec
return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "davidmh/cspell.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    cond = function()
      local astro_root = rooter.detect(0, false, {
        detector = { { ".cspell.json" } },
      })[1]
      return astro_root ~= nil
    end,
    opts = function(_, opts)
      local cspell_diagnostics = require "cspell.diagnostics"
      local cspell_code_actions = require "cspell.code_actions"

      opts.sources = vim.list_extend(opts.sources or {}, {
        cspell_diagnostics,
        cspell_code_actions,
      })
    end,
  },
}
