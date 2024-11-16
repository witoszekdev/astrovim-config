---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      -- { "haydenmeade/neotest-jest" },
      { "marilari88/neotest-vitest" },
      { "nvim-neotest/neotest-python" },
    },
    opts = {
      adapters = {
        -- "neotest-jest",
        "neotest-vitest",
        "neotest-python",
      },
    },
  },
}
