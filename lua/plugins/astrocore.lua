-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup (v5 format)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    sessions = {
      ignore = {
        filetypes = { "NeogitStatus", "NeogitCommitMessage", "NeogitPopup", "NeogitLogView" },
      },
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    commands = {
      SessionCleanup = {
        function()
          for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
            vim.t[tabpage].bufs = vim.tbl_filter(
              function(b) return type(b) == "number" and vim.api.nvim_buf_is_valid(b) end,
              vim.t[tabpage].bufs or {}
            )
          end
          vim.notify("Session buffer list cleaned up", vim.log.levels.INFO)
        end,
        desc = "Clean up invalid entries from session buffer lists",
      },
      G = {
        function() require("neogit").open() end,
        desc = "Open Neogit",
      },
      CopyRelativePath = {
        function()
          local path = vim.fn.expand("%:p")
          if path == "" then return vim.notify("Buffer has no file", vim.log.levels.WARN) end
          local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
          if vim.v.shell_error ~= 0 then return vim.notify("Not in a git repo", vim.log.levels.WARN) end
          local rel = vim.fs.normalize(path):sub(#vim.fs.normalize(root) + 2)
          vim.fn.setreg("+", rel)
          vim.notify("Copied: " .. rel)
        end,
        desc = "Copy file path relative to Git root to clipboard",
      },
      CopyFullPath = {
        function()
          local path = vim.fs.normalize(vim.fn.expand("%:p"))
          if path == "" then return vim.notify("Buffer has no file", vim.log.levels.WARN) end
          vim.fn.setreg("+", path)
          vim.notify("Copied: " .. path)
        end,
        desc = "Copy full file path to clipboard",
      },
      CopyFileName = {
        function()
          local name = vim.fn.expand("%:t")
          if name == "" then return vim.notify("Buffer has no file", vim.log.levels.WARN) end
          vim.fn.setreg("+", name)
          vim.notify("Copied: " .. name)
        end,
        desc = "Copy filename to clipboard",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      t = {
        ["<C-w>h"] = { "<C-\\><C-n><C-w>h", desc = "Navigate to left window" },
        ["<C-w>j"] = { "<C-\\><C-n><C-w>j", desc = "Navigate to down window" },
        ["<C-w>k"] = { "<C-\\><C-n><C-w>k", desc = "Navigate to up window" },
        ["<C-w>l"] = { "<C-\\><C-n><C-w>l", desc = "Navigate to right window" },
        ["<C-w><C-h>"] = { "<C-\\><C-n><C-w>h", desc = "Navigate to left window" },
        ["<C-w><C-j>"] = { "<C-\\><C-n><C-w>j", desc = "Navigate to down window" },
        ["<C-w><C-k>"] = { "<C-\\><C-n><C-w>k", desc = "Navigate to up window" },
        ["<C-w><C-l>"] = { "<C-\\><C-n><C-w>l", desc = "Navigate to right window" },
      },
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<C-p>"] = { function() Snacks.picker.files() end, desc = "Find files" },
        ["<C-->"] = { function() vim.cmd "vertical resize -5" end, desc = "Smaller vim window" },
        ["<C-=>"] = { function() vim.cmd "vertical resize +5" end, desc = "Bigger vim window" },

        ["<Leader>q"] = {
          function() require("replacer").run() end,
          desc = "Run replacer.nvim",
        },

        ["<Leader>o"] = {
          function()
            require("neo-tree.command").execute {
              action = "focus",
              source = "filesystem",
              reveal = true,
            }
          end,
          desc = "Neotree: Focus on current file",
        },

        -- buffer overrides
        ["<Leader>bc"] = false,
        ["<Leader>bC"] = false,
        ["<Leader>ba"] = {
          function() require("astrocore.buffer").close_all(true) end,
          desc = "Close all buffers except current",
        },
        ["<Leader>bA"] = {
          function() require("astrocore.buffer").close_all() end,
          desc = "Close all buffers",
        },
        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        ["<Leader>bb"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" },
        ["<Leader>bB"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Force close buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
