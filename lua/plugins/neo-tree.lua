---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    if not opts.filesystem then opts.filesystem = {} end
    opts.filesystem.bind_to_cwd = true
    opts.filesystem.follow_current_file = { enabled = true }
    opts.filesystem.hijack_netrw_behavior = "open_default"
    opts.filesystem.use_libuv_file_watcher = true
    
    -- Show dotfiles by default
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
    
    opts.open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "edgy", "snacks_dashboard", "alpha" }
    
    return opts
  end,
}
