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

-- Function to get the Git repository root for a given file path
local function get_git_root(file_path)
  -- Check if git executable is available in Neovim's environment
  if vim.fn.executable('git') == 0 then
    vim.notify("`git` command not found. Make sure git is installed and accessible in Neovim's PATH.", vim.log.levels.ERROR)
    return nil
  end

  -- Get the directory containing the file
  local file_dir = vim.fn.fnamemodify(file_path, ':h')
  -- Check if the directory exists using Lua's file system operations
  if not vim.loop.fs_stat(file_dir) then
    vim.notify("Directory not found for CWD: " .. file_dir, vim.log.levels.WARN)
    return nil
  end

  -- Use pcall to safely call systemlist and capture potential errors during execution setup
  local success, result = pcall(vim.fn.systemlist, 'git rev-parse --show-toplevel')

  -- 1. Check if pcall itself failed (e.g., issues setting up the command execution)
  if not success then
      -- result contains the error message/object in case of pcall failure
      -- Use vim.inspect() for safer serialization of the error object
      vim.notify("Failed to initiate git command execution. Error: " .. vim.inspect(result), vim.log.levels.ERROR)
      return nil
  end

  -- 2. pcall succeeded, meaning the command was likely executed.
  --    Now check the shell exit code stored in vim.v.shell_error.
  if vim.v.shell_error == 0 then
    -- Command executed successfully (exit code 0)
    -- Check if 'result' (the actual output from systemlist) is a table and has content
    if type(result) == "table" and #result > 0 then
      -- Return the first line of output, which is the git root path
      -- Trim potential whitespace/newlines
      return vim.fn.trim(result[1])
    else
      -- Command succeeded but returned no output (or unexpected type)
      vim.notify("`git rev-parse --show-toplevel` executed successfully but returned no output.", vim.log.levels.WARN)
      return nil
    end
  else
    -- Command executed but failed (non-zero exit code)
    local error_message = "Git command failed with exit code " .. vim.v.shell_error .. "."
    -- Try to include stderr if available in the result (systemlist might include it)
    if type(result) == "table" and #result > 0 then
       error_message = error_message .. " Output: " .. table.concat(result, "\n")
    end
    vim.notify(error_message, vim.log.levels.ERROR)
    return nil
  end
end

-- Function to copy the relative path to the clipboard
local function copy_relative_path()
  -- Get the full path of the current buffer
  local current_file_path = vim.fn.expand('%:p')

  -- Check if the buffer has a file path (e.g., not an unnamed buffer)
  if current_file_path == '' then
    vim.notify("Cannot copy relative path: Buffer is not associated with a file.", vim.log.levels.WARN)
    return
  end

  -- Get the Git repository root
  local git_root = get_git_root(current_file_path)

  if git_root then
    -- Normalize paths for consistent separator usage (optional but good practice)
    local normalized_file_path = vim.fs.normalize(current_file_path)
    local normalized_git_root = vim.fs.normalize(git_root)

    -- Calculate the relative path
    -- string.sub extracts the part of the file path starting after the root path + 1 (for the separator)
    -- Ensure the file path actually starts with the git root path before slicing
    if normalized_file_path:find(normalized_git_root, 1, true) == 1 then
        -- Calculate relative path, ensuring it handles the separator correctly
        -- Check if paths are identical (file is the root), handle appropriately
        if #normalized_file_path == #normalized_git_root then
            -- Handle case where the file path is the git root itself
             vim.notify("Cannot determine relative path for the repository root directory itself.", vim.log.levels.WARN)
             return -- Or set relative_path to "" or "." depending on desired behavior
        end
        -- Ensure there's a separator before taking the substring
        if #normalized_file_path > #normalized_git_root + 1 then
             local relative_path = string.sub(normalized_file_path, #normalized_git_root + 2) -- +2 to account for the path separator '/'
             -- Copy the relative path to the system clipboard register '+'
             vim.fn.setreg('+', relative_path)
             -- Notify the user
             vim.notify("Copied relative path: " .. relative_path, vim.log.levels.INFO)
        else
             -- This case should ideally not happen if find succeeded and lengths differ, but added for safety
             vim.notify("Error calculating relative path: Path structure unexpected.", vim.log.levels.ERROR)
        end
    else
        vim.notify("Error: File path '" .. normalized_file_path .. "' does not seem to be inside the detected Git root '" .. normalized_git_root .. "'.", vim.log.levels.ERROR)
    end
  else
    -- Notify the user if not in a Git repository (get_git_root handles specific errors)
    vim.notify("Could not determine Git root. Cannot copy relative path.", vim.log.levels.WARN)
  end
end

-- Function to copy the full path to the clipboard
local function copy_full_path()
  -- Get the full path of the current buffer
  local current_file_path = vim.fn.expand('%:p')

  -- Check if the buffer has a file path (e.g., not an unnamed buffer)
  if current_file_path == '' then
    vim.notify("Cannot copy full path: Buffer is not associated with a file.", vim.log.levels.WARN)
    return
  end

  -- Normalize path (optional, but good for consistency)
  local normalized_file_path = vim.fs.normalize(current_file_path)

  -- Copy the full path to the system clipboard register '+'
  vim.fn.setreg('+', normalized_file_path)
  -- Notify the user
  vim.notify("Copied full path: " .. normalized_file_path, vim.log.levels.INFO)
end

-- Function to copy just the filename (basename) to the clipboard
local function copy_file_name()
  -- Get the full path of the current buffer
  local current_file_path = vim.fn.expand('%:p')

  -- Check if the buffer has a file path (e.g., not an unnamed buffer)
  if current_file_path == '' then
    vim.notify("Cannot copy filename: Buffer is not associated with a file.", vim.log.levels.WARN)
    return
  end

  -- Extract the filename (tail) from the full path
  local file_name = vim.fn.fnamemodify(current_file_path, ':t')

  -- Check if filename extraction was successful (it should be unless path is weird)
  if file_name == '' and current_file_path ~= '' then
      vim.notify("Could not extract filename from path: " .. current_file_path, vim.log.levels.WARN)
      return
  end

  -- Copy the filename to the system clipboard register '+'
  vim.fn.setreg('+', file_name)
  -- Notify the user
  vim.notify("Copied filename: " .. file_name, vim.log.levels.INFO)
end


-- Create the user command :CopyRelativePath
vim.api.nvim_create_user_command(
  'CopyRelativePath',
  copy_relative_path,
  { nargs = 0, bar = true, desc = "Copy file path relative to Git root to clipboard" }
)

-- Create the user command :CopyFullPath
vim.api.nvim_create_user_command(
  'CopyFullPath',
  copy_full_path,
  { nargs = 0, bar = true, desc = "Copy full file path to clipboard" }
)

-- Create the user command :CopyFileName
vim.api.nvim_create_user_command(
  'CopyFileName',
  copy_file_name,
  { nargs = 0, bar = true, desc = "Copy only the filename to clipboard" }
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
