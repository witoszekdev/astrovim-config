-- v6: mason renamed williamboman/mason.nvim -> mason-org/mason.nvim

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "debugpy",
        "tree-sitter-cli",
      },
    },
  },
}
