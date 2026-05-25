-- v6: mason renamed (williamboman/mason.nvim -> mason-org/mason.nvim).
-- The nvim-lspconfig `opts.servers` pattern is incompatible with v6's vim.lsp.config flow.
-- graphql server filetypes are now configured in lua/plugins/astrolsp.lua under `config.graphql`.

---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "graphql-language-service-cli",
      },
    },
  },
}
