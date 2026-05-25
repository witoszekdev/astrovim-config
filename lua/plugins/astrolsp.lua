-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- v6: `config` table is forwarded to `vim.lsp.config[server]` (replaces lspconfig opts).
--     Per-server settings can also live in `lsp/<server_name>.lua`.

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    -- customize lsp formatting options
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {},
        ignore_filetypes = {},
      },
      disabled = {},
      timeout_ms = 1000,
    },
    -- enable servers that you already have installed without mason
    servers = {
      "textlsp",
    },
    -- customize language server configuration passed to `vim.lsp.config`
    ---@diagnostic disable: missing-fields
    config = {
      textLSP = {},
      denols = {
        single_file_support = false,
        root_dir = function(arg, on_dir)
          local start = type(arg) == "number" and vim.api.nvim_buf_get_name(arg) or arg
          if type(start) ~= "string" or start == "" then return end
          if start:find("/node_modules/", 1, true) then return end
          local dir = vim.fn.fnamemodify(start, ":h")
          local found = vim.fs.find({ "deno.json", "deno.jsonc" }, {
            upward = true,
            path = dir,
            stop = vim.uv.os_homedir(),
          })[1]
          if not found then return end
          local root = vim.fn.fnamemodify(found, ":h")
          if type(on_dir) == "function" then on_dir(root) end
          return root
        end,
      },
      graphql = {
        filetypes = {
          "graphql",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "tsx",
        },
      },
      vtsls = {
        root_dir = function(arg, on_dir)
          local start = type(arg) == "number" and vim.api.nvim_buf_get_name(arg) or arg
          if type(start) ~= "string" or start == "" then return end
          local dir = vim.fn.fnamemodify(start, ":h")
          local stop = vim.uv.os_homedir()
          local deno = vim.fs.find({ "deno.json", "deno.jsonc" }, {
            upward = true,
            path = dir,
            stop = stop,
          })[1]
          if deno and not deno:find("/node_modules/", 1, true) then return end
          local found = vim.fs.find({ "tsconfig.json", "package.json", "jsconfig.json", ".git" }, {
            upward = true,
            path = dir,
            stop = stop,
          })[1]
          if not found then return end
          local root = vim.fn.fnamemodify(found, ":h")
          if type(on_dir) == "function" then on_dir(root) end
          return root
        end,
        settings = {
          vtsls = {
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
                entriesLimit = 50,
              },
            },
          },
        },
      },
    },
    -- customize how language servers are attached
    -- v6: default handler is `vim.lsp.enable`; only override if needed.
    handlers = {},
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gr = {
          function()
            Snacks.picker.lsp_references {
              include_declaration = false,
              jump = { reuse_win = true },
            }
          end,
          desc = "LSP References (excluding imports)",
        },
      },
    },
    on_attach = function(client, bufnr) end,
  },
}
