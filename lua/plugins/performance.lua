return {
  {
	  "chrisgrieser/nvim-early-retirement",
	  config = true,
	  event = "VeryLazy",
  },
  {
    "wakatime/vim-wakatime",
    optional = true,
    init = function()
      vim.g.wakatime_ScreenRedraw = 0
      vim.g.wakatime_CLIPath = vim.fn.exepath("wakatime-cli")
    end,
  },
}
