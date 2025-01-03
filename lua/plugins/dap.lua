-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "microsoft/vscode-js-debug",
        build = "pnpm install && pnpx gulp vsDebugServerBundle && mv dist out",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        opts = {
          debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
          adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
        },
      },
    },
    config = function(_, opts)
      local dap = require "dap" -------------------------------------------------------------------------
      -- Configurations
      -------------------------------------------------------------------------
      -- Adapter configuration and installation instructions:
      --   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

      local function url_prompt(default)
        default = default or "http://localhost:3000"
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({ prompt = "Enter URL: ", default = default }, function(url)
            if url == nil or url == "" then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end

      local function port_prompt(default)
        default = default or "9229"
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({ prompt = "Enter port, default is 9229: ", default = default }, function(port)
            if port == nil or port == "" then
              return
            else
              coroutine.resume(co, port)
            end
          end)
        end)
      end

      -- web dev configs
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          {
            -- make sure to start up Chrome in debug mode first:
            -- $ google-chrome --remote-debugging-port=9222 --user-data-dir=remote-debug-profile
            name = "Attach to Chrome process (port 9222)",
            type = "pwa-chrome",
            request = "attach",
            cwd = vim.uv.cwd(),
            port = 9222,
            webRoot = "${workspaceFolder}",
          },

          {
            name = "nextjsss",
            type = "pwa-node",
            request = "attach",
            port = 9230,
            address = "127.0.0.1",
          },

          {
            name = "Launch Chrome (prompt for URL)",
            type = "pwa-chrome",
            request = "launch",
            sourceMaps = true,
            url = url_prompt,
            webRoot = vim.uv.cwd(),
            userDataDir = false,
          },

          {
            name = "Attach to Node process",
            type = "pwa-node",
            request = "attach",
            processId = require("dap.utils").pick_process,
          },

          {
            name = "Attach to Node (url)",
            type = "pwa-node",
            request = "attach",
            address = "127.0.0.1",
            cwd = vim.uv.cwd(),
            url = url_prompt,
          },

          {
            name = "Attach to Node (port)",
            type = "pwa-node",
            request = "attach",
            cwd = vim.uv.cwd(),
            port = port_prompt,
          },

          {
            name = "Debug current Node file",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
          },

          {
            name = "Debug current TypeScript Node file (ts-node)",
            type = "pwa-node",
            request = "launch",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
            runtimeArgs = { "--loader", "ts-node/esm" },
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },

          {
            name = "Debug jest tests",
            type = "pwa-node",
            request = "launch",
            -- trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end
    end,
  },
}
