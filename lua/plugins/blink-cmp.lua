-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
---@diagnostic disable-next-line: unused-local
local blink = require "blink.cmp"

---@type LazySpec
return {
  {
    -- re-enable luasnip for other plugins
    "L3MON4D3/LuaSnip",
    enabled = true,
  },
  {
    "Saghen/blink.cmp",
    version = nil,
    build = "cargo build --release",
    --- @type blink.cmp.Config
    opts = {
      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = true } },
      windows = {
        autocomplete = {
          selection = "manual",
        },
      },
      keymap = {
        -- ["<M-l>"] = { "accept" },
      },
    },
  },
}
