-- Customize Mason

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "vtsls",
        "eslint-lsp",
        "prettier",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "json-lsp",
        "yaml-language-server",
        "marksman",
        "markdown-toc",
        "markdownlint",
        "ruff",
        "pyright",
        "sqlls",
        "terraform-ls",
        "tflint",
        "gopls",
        "goimports",
        "gofumpt",
        "gomodifytags",
        "impl",
        "delve",
        "graphql-language-service-cli",
      },
    },
  },
}
