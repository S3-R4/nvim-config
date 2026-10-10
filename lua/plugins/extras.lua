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
    init = function()
      vim.g.flog_enable_dynamic_commit_hl = true
      vim.g.flog_default_opts = {
        all = true,
        graph = true,
        default_collapsed = true,
        format = "%d %<(36,trunc)%s",
        open_cmd = "botright 52vsplit",
      }
    end,
    keys = { { "<leader>gl", function() require("config.git_graph").toggle() end, desc = "Toggle Git graph sidebar" } },
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
