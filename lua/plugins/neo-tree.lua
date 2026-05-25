---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    if not opts.filesystem then opts.filesystem = {} end
    opts.filesystem.bind_to_cwd = true
    opts.filesystem.follow_current_file = { enabled = true }
    opts.filesystem.hijack_netrw_behavior = "open_default"
    opts.filesystem.use_libuv_file_watcher = true

    if not opts.filesystem.filtered_items then opts.filesystem.filtered_items = {} end
    opts.filesystem.filtered_items.hide_dotfiles = false
    opts.filesystem.window = {
      mappings = {
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["f"] = "filter_on_submit",
      }
    }

    if not opts.window then opts.window = {} end
    opts.window.position = "left"
    opts.window.width = 30

    if not opts.event_handlers then opts.event_handlers = {} end
    table.insert(opts.event_handlers, {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.cmd("setlocal relativenumber")
      end,
    })
    -- Wipe stale neo-tree buffers before opening to avoid E95 (buffer name collision)
    -- at renderer.lua:1228 when a previously-named neo-tree buffer was not cleaned up.
    table.insert(opts.event_handlers, {
      event = "neo_tree_window_before_open",
      handler = function(args)
        local target_source = args and args.source
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(bufnr) then
            local name = vim.api.nvim_buf_get_name(bufnr)
            local basename = name:match("([^/]+)$") or name
            local src = basename:match("^neo%-tree ([^ ]+) %[%d+%]$")
            if src and (not target_source or src == target_source) then
              local winids = vim.fn.win_findbuf(bufnr)
              if #winids == 0 then
                pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
              end
            end
          end
        end
      end,
    })

    opts.open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "edgy", "snacks_dashboard", "alpha" }

    return opts
  end,
}
