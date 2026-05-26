-- deno-nvim wraps deprecated `require('lspconfig')`. denols already
-- configured natively via astrolsp.lua, so disable the wrapper.
---@type LazySpec
return {
  "sigmasd/deno-nvim",
  enabled = false,
}
