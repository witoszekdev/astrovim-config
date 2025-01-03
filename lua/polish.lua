-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

vim.api.nvim_create_user_command(
  "G",
  function() require("neogit").open() end,
  { desc = "Open Neogit", nargs = "*", bang = true }
)

vim.opt.clipboard = ""

-- Check if running in Neovim
-- if vim.fn.has "nvim" == 1 then
--   -- Set environment variable for nested Neovim instances
--   vim.env.VISUAL = "nvr -cc split --remote-wait"
--   vim.env.EDITOR = "nvr -cc split --remote-wait"
--
--   -- Set up autocmd to handle nested Neovim instances
--   vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "gitcommit", "gitrebase", "gitconfig" },
--     callback = function()
--       -- Unset wait for these file types
--       vim.opt_local.bufhidden = "delete"
--       vim.cmd [[
--         if has('nvim')
--           set noswapfile
--         endif
--       ]]
--     end,
--   })
-- end
--
-- -- Optional: Set up a command to start server if not already running
-- vim.api.nvim_create_user_command("StartServer", function()
--   if vim.fn.exists "$NVIM_LISTEN_ADDRESS" == 0 then vim.fn.serverstart "/tmp/nvimsocket" end
-- end, {})
