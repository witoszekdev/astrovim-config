-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- language packs
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.typescript-all-in-one" }, -- deno broken in v0.12
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.mdx" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.basedpyright" },
  { import = "astrocommunity.pack.python.ruff" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.go" },

  { import = "astrocommunity.colorscheme.gruvbox-nvim" },

  -- recipes
  { import = "astrocommunity.recipes.auto-session-restore" },
  { import = "astrocommunity.recipes.diagnostic-virtual-lines-current-line" },
  -- { import = "astrocommunity.recipes.picker-lsp-mappings" },

  -- other
  { import = "astrocommunity.search.grug-far-nvim" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.completion.blink-cmp" },
  -- { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-bracketed" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.comment.ts-comments-nvim" },
  { import = "astrocommunity.git.gitlinker-nvim" },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.nvim-tinygit" },
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.gitgraph-nvim" },
  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.docker.lazydocker" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  -- { import = "astrocommunity.lsp.ts-error-translator-nvim" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.lsp-lens-nvim" },
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  -- { import = "astrocommunity.editing-support.copilotchat-nvim" },
  { import = "astrocommunity.media.img-clip-nvim" },
  -- { import = "astrocommunity.media.vim-wakatime" }, -- Disabled due to file descriptor issues
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.text-case-nvim" },
  { import = "astrocommunity.editing-support.treesj" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },
  { import = "astrocommunity.editing-support.conform-nvim" },
  -- { import = "astrocommunity.editing-support.bigfile-nvim" },
  { import = "astrocommunity.debugging.nvim-chainsaw" },
  { import = "astrocommunity.scrolling.mini-animate" },

  -- { import = "astrocommunity.ai.opencode-nvim" },
  { import = "astrocommunity.ai.codecompanion-nvim" },

  { import = "astrocommunity.utility.nvzone-menu" },

  -- import/override with your plugins folder
}
