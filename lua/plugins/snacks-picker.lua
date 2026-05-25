-- Snacks picker configuration
-- Customizes the snacks.nvim picker behavior

---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    if not opts.picker then opts.picker = {} end

    local exclude = {
      ".git",
      "node_modules",
      "dist",
      "build",
      "out",
      ".next",
      ".turbo",
      ".cache",
      ".venv",
      "target",
      "*.lock",
      "pnpm-lock.yaml",
      "package-lock.json",
      "yarn.lock",
    }

    opts.picker = vim.tbl_deep_extend("force", opts.picker, {
      matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
      },

      layout = {
        preset = function() return vim.o.columns >= 120 and "default" or "vertical" end,
      },

      sources = {
        files = {
          hidden = false,
          ignored = true,
          exclude = exclude,
        },
        grep = {
          hidden = false,
          ignored = true,
          exclude = exclude,
        },
        smart = {
          hidden = true,
          ignored = true,
          exclude = exclude,
        },
      },
    })

    return opts
  end,
}
