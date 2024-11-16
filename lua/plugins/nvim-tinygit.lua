---@type LazySpec
return {
  {
    "chrisgrieser/nvim-tinygit",
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>gN"] = { function() require("tinygit").smartCommit() end, desc = "New commit" },
            ["<Leader>gp"] = { function() require("tinygit").push() end },
          },
        },
      },
    },
  },
}
