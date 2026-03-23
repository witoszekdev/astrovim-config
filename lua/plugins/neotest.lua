---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "haydenmeade/neotest-jest" },
      { "marilari88/neotest-vitest" },
      { "nvim-neotest/neotest-python" },
    },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require("neotest-jest")({
        jestCommand = "./node_modules/.bin/jest",
        jest_test_discovery = true,
        cwd = function() return vim.fn.getcwd() end,
      }))
      table.insert(opts.adapters, require("neotest-vitest"))
      table.insert(opts.adapters, require("neotest-python")({ dap = { justMyCode = false } }))
    end,
  },
}
