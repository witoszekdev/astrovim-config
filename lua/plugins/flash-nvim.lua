---@type LazySpec
return {
  {
    "folke/flash.nvim",
    opts = {
      label = {
        rainbow = {
          enabled = true,
        },
      },
      ---@type table<string, Flash.Config>
      modes = {
        search = {},
        treesitter = {
          search = {
            incremental = true,
          },
        },
        char = {
          jump_labels = true,
        },
      },
    },
  },
}
