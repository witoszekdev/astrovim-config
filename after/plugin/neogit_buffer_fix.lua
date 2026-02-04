-- Patch for Neogit terminal channel issue with Neovim 0.11+
-- Fixes: "Terminal already connected to buffer" error
-- See: https://github.com/NeogitOrg/neogit/issues/1463

local function patch_neogit_buffer()
  local ok, buffer_module = pcall(require, "neogit.lib.buffer")
  if not ok then return end

  local Buffer = buffer_module.Buffer
  if not Buffer then return end

  -- Store original function
  local original_open_terminal_channel = Buffer.open_terminal_channel

  -- Patch the function to properly close existing channels
  function Buffer:open_terminal_channel()
    -- Close existing channel if present (Neovim 0.11+ compatibility fix)
    if self.chan then
      pcall(vim.fn.chanclose, self.chan)
      self.chan = nil
    end

    -- Call original function
    return original_open_terminal_channel(self)
  end
end

-- Apply patch after Neogit loads
vim.api.nvim_create_autocmd("User", {
  pattern = "NeogitPluginLoaded",
  callback = patch_neogit_buffer,
  once = true,
})

-- Fallback: try patching immediately if Neogit is already loaded
vim.defer_fn(function()
  if package.loaded["neogit.lib.buffer"] then patch_neogit_buffer() end
end, 100)
