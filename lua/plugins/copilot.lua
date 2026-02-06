---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    opts = function(_, opts)
      -- Use proto's latest node v22 to ensure compatibility
      local ok, proto_node = pcall(vim.fn.system, "proto bin node 22")
      if ok and vim.v.shell_error == 0 then
        opts.copilot_node_command = vim.trim(proto_node)
      end

      opts.suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      }

      opts.filetypes = {
        markdown = true,
        gitcommit = true,
      }

      -- Disable the panel to avoid notification spam
      opts.panel = {
        enabled = false,
      }

      return opts
    end,
  },
}
