-- Snacks picker configuration
-- Customizes the snacks.nvim picker behavior

---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Extend existing snacks config
    if not opts.picker then opts.picker = {} end
    
    -- Add custom picker configuration
    opts.picker = vim.tbl_deep_extend("force", opts.picker, {
      -- Enable fuzzy matching
      matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
      },
      
      -- Customize layouts
      layout = {
        preset = function()
          return vim.o.columns >= 120 and "default" or "vertical"
        end,
      },
      
      -- You can add more custom configurations here
      -- See: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
    })
    
    return opts
  end,
}
