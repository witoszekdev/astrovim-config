---@type LazySpec
return {
  {
    "tummetott/unimpaired.nvim",
    event = "VeryLazy",
    opts = {
      keymaps = {
        blank_above = {
          mapping = "[<Space>",
          description = "Add [count] blank lines above",
          dot_repeat = true,
        },
        blank_below = {
          mapping = "]<Space>",
          description = "Add [count] blank lines below",
          dot_repeat = true,
        },
        exchange_above = {
          mapping = "[e",
          description = "Exchange line with [count] lines above",
          dot_repeat = true,
        },
        exchange_below = {
          mapping = "]e",
          description = "Exchange line with [count] lines below",
          dot_repeat = true,
        },
        exchange_section_above = {
          mapping = "[e",
          description = "Move section [count] lines up",
          dot_repeat = true,
        },
        exchange_section_below = {
          mapping = "]e",
          description = "Move section [count] lines down",
          dot_repeat = true,
        },
        previous_file = {
          mapping = "[f",
          description = "Previous file in directory. :colder in qflist",
          dot_repeat = true,
        },
        next_file = {
          mapping = "]f",
          description = "Next file in directory. :cnewer in qflist",
          dot_repeat = true,
        },
      },
      default_keymaps = false,
    },
  },
}
