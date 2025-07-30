---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "haydenmeade/neotest-jest" },
      -- { "marilari88/neotest-vitest" },
      { "nvim-neotest/neotest-python" },
    },
    opts = {
      adapters = {
        "neotest-jest",
        -- "neotest-vitest",
        "neotest-python",
      },
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-jest"] = {
        jestCommand = "./node_modules/.bin/jest",
        jest_test_discovery = true,
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      }
      opts.adapters["neotest-python"] = {
        dap = { justMyCode = false },
      }
      return opts
    end,
    -- config = function(_, opts)
    --   if opts.adapters then
    --     local adapters = {}
    --     for name, config in pairs(opts.adapters or {}) do
    --       if type(name) == "number" then
    --         if type(config) == "string" then config = require(config) end
    --         adapters[#adapters + 1] = config
    --       elseif config ~= false then
    --         local adapter = require(name)
    --         if type(config) == "table" and not vim.tbl_isempty(config) then
    --           local meta = getmetatable(adapter)
    --           if adapter.setup then
    --             adapter.setup(config)
    --           elseif meta and meta.__call then
    --             adapter(config)
    --           else
    --             error("Adapter " .. name .. " does not support setup")
    --           end
    --         end
    --         adapters[#adapters + 1] = adapter
    --       end
    --     end
    --     opts.adapters = adapters
    --   end
    --   vim.diagnostic.config({
    --     virtual_text = {
    --       format = function(diagnostic)
    --         local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
    --         return message
    --       end,
    --     },
    --   }, vim.api.nvim_create_namespace "neotest")
    --   require("neotest").setup(opts)
    -- end,
  },
}
