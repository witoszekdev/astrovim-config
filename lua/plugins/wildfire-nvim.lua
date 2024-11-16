---@type LazySpec
return {
  {
    "sustech-data/wildfire.nvim",
    opts = {
      keymaps = {
        init_selection = "<C-Space>",
        node_incremental = "<C-Space>",
        node_decremental = "<BS>", -- BS = backspace
      },
    },
  },
}
