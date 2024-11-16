return {
  {
    "Saghen/blink.cmp",
    version = "*",
    build = "cargo build --release",
    opts = {
      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = true } },
    },
  },
}
