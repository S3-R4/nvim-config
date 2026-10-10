local settings = require("config.settings")
return {
  {
    "error311/wayfinder.nvim",
    enabled = settings.features.wayfinder,
    cmd = { "Wayfinder", "WayfinderTrailOpen", "WayfinderTrailResume" },
    opts = { performance = "fast" },
    keys = {
      { "<leader>ce", "<cmd>Wayfinder<cr>", desc = "Explore symbol" },
      { "<leader>ct", "<cmd>WayfinderTrailOpen<cr>", desc = "Exploration trail" },
    },
  },
  {
    "tpope/vim-fugitive",
    enabled = settings.features.git_history,
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Gedit" },
    keys = { { "<leader>gg", "<cmd>Git<cr>", desc = "Git status" } },
  },
  {
    "rbong/vim-flog",
    enabled = settings.features.git_history,
    dependencies = { "tpope/vim-fugitive" },
    cmd = { "Flog", "Flogsplit" },
    keys = { { "<leader>gl", "<cmd>Flog<cr>", desc = "Git history graph" } },
  },
  {
    "DRoma82/add-subtract-ex.nvim",
    enabled = settings.features.add_subtract,
    keys = { "<C-a>", "<C-x>" },
    opts = { sign_aware = true },
  },
  {
    "sjclayton/goplexity.nvim",
    ft = settings.features.goplexity and "go" or nil,
    cmd = "Goplexity",
    opts = { enabled = settings.features.goplexity },
    keys = { { "<leader>tc", "<cmd>Goplexity<cr>", desc = "Toggle Go complexity hints" } },
  },
}
