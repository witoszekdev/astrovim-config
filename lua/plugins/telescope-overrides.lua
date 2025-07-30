---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function (_, opts)
      local actions = require "telescope.actions"
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = vim.tbl_deep_extend("force", opts.defaults.mappings or {}, {
          i = vim.tbl_deep_extend("force", opts.defaults.mappings.i or {}, {
            ["<C-I>"] = actions.cycle_history_next,
            ["<C-P>"] = actions.cycle_history_prev
          })
        }),
      })
      return opts
    end,
  }
}
