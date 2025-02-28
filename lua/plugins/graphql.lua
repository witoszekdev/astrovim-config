return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "graphql-language-service-cli",
      },
    },
  },

  {
      "neovim/nvim-lspconfig",
  opts = {
    servers = {
      graphql = {
        filetypes = { "graphql", "typescript", "typescriptreact" }
      }
    },
  },
  }
}
