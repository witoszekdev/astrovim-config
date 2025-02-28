-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- language packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.mdx" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.yaml" },

  { import = "astrocommunity.colorscheme.gruvbox-nvim" },
  -- other
  { import = "astrocommunity.recipes.auto-session-restore" },
  { import = "astrocommunity.recipes.telescope-lsp-mappings" },
  { import = "astrocommunity.search.grug-far-nvim" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.completion.blink-cmp" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-bracketed" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.nvim-spider" }, -- test this out, changes w motion
  { import = "astrocommunity.comment.ts-comments-nvim" },
  { import = "astrocommunity.git.gitlinker-nvim" },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.nvim-tinygit" },
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.gitgraph-nvim" },
  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.docker.lazydocker" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.lsp.ts-error-translator-nvim" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.lsp-lens-nvim" },
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  { import = "astrocommunity.lsp.delimited-nvim" },
  { import = "astrocommunity.editing-support.copilotchat-nvim" },
  -- { import = "astrocommunity.media.image-nvim" },
  { import = "astrocommunity.media.img-clip-nvim" },
  { import = "astrocommunity.media.vim-wakatime" },

  -- { import = "astrocommunity.git.fugit2-nvim" },
  -- we already have context in Asrtovim, so maybe let's try it out
  -- { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  -- { import = "astrocommunitt.editing-support.nvim-origami" },
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.text-case-nvim" },
  { import = "astrocommunity.editing-support.treesj" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },
  { import = "astrocommunity.editing-support.bigfile-nvim" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.debugging.nvim-chainsaw" },
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  { import = "astrocommunity.debugging.telescope-dap-nvim" },
  -- { import = "astrocommunity.workflow.hardtime-nvim" }, -- annoyting on purpose
  { import = "astrocommunity.scrolling.mini-animate" },

  -- todo: check it out later
  -- { import = "astrocommunity.code-runner.sniprun" },

  -- import/override with your plugins folder
}
