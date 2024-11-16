---@diagnostic disable-next-line: unused-local
local blink = require "blink.cmp"

---@type LazySpec
return {
  {
    "Saghen/blink.cmp",
    version = "*",
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
        ["<M-l>"] = { "accept" },
      },
    },
  },
}
