---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  opts = {
    adapters = {
      acp = {
        opencode = function()
          return require("codecompanion.adapters").extend("opencode", {
            -- OpenCode uses default configuration from ~/.config/opencode/config.json
            -- You can customize model selection in that file
          })
        end,
      },
    },
    interactions = {
      chat = {
        adapter = "opencode", -- Set OpenCode as default adapter
      },
    },
  },
}
