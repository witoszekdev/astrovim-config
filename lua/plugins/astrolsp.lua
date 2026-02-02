-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

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
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      textLSP = {},
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
        settings = {
          vtsls = {
            -- autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
                entriesLimit = 50
              }
            }
          }
        }
      }
    },
    -- customize how language servers are attached
    handlers = {},
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gr = {
          function()
            Snacks.picker.lsp_references {
              include_declaration = false,
              jump = { reuse_win = true },
              -- Note: snacks uses 'exclude' patterns, not file_ignore_patterns
              -- Pattern filtering is handled differently - you can filter in the picker UI
            }
          end,
          desc = "LSP References (excluding imports)",
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    on_attach = function(client, bufnr) end,
  },
}
