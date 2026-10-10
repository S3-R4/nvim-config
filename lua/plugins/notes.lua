local settings = require("config.settings")
return {
  {
    "snapwich/obsidian-tasks.nvim",
    ft = "markdown",
    cmd = "ObsidianTask",
    dependencies = { "obsidian-nvim/obsidian.nvim" },
    opts = {
      setup_keymaps = false, -- keep our search/project mappings intact
      date_input = { natural_language = false },
    },
    keys = {
      { "<leader>nD", "<cmd>ObsidianTask render<cr>", desc = "Render task dashboard" },
      { "<leader>nr", "<cmd>ObsidianTask refresh<cr>", desc = "Refresh vault tasks" },
      { "<leader>ne", "<cmd>ObsidianTask due<cr>", desc = "Set task due date" },
      { "<leader>np", "<cmd>ObsidianTask priority<cr>", desc = "Set task priority" },
      { "<leader>ng", "<cmd>ObsidianTask goto<cr>", desc = "Go to task source" },
      { "<leader>na", "<cmd>ObsidianTask new<cr>", desc = "Add vault task" },
    },
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      if settings.notes.vault == "" then return end
      require("obsidian").setup({
        workspaces = { { name = "notes", path = vim.fn.expand(settings.notes.vault) } },
        legacy_commands = false,
        picker = { name = "snacks.picker" },
        frontmatter = { enabled = false }, -- never rewrite note metadata on save
        ui = { enable = false }, -- preserve the Markdown source view
      })
    end,
    keys = {
      { "<leader>nn", function() require("config.notes").run("new") end, desc = "New note" },
      { "<leader>nd", function() require("config.notes").run("today") end, desc = "Daily note" },
      { "<leader>nb", function() require("config.notes").run("backlinks") end, desc = "Note backlinks" },
      { "<leader>nl", function() require("config.notes").run("follow_link") end, desc = "Follow note link" },
      { "<leader>nc", function() require("config.notes").toggle_checkbox() end, desc = "Toggle Markdown checkbox" },
    },
  },
  {
    "mariocesar/beside.nvim",
    cmd = "Beside",
    opts = { width = 0.4, delay = 200 },
    keys = { { "<leader>mp", "<cmd>Beside<cr>", desc = "Markdown preview split" } },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    opts = { signs = false },
    keys = {
      { "<leader>tt", function() Snacks.picker.todo_comments() end, desc = "Code TODO comments" },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next code TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous code TODO" },
    },
  },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = settings.latex.viewer
      if settings.latex.viewer == "zathura" and vim.fn.executable("zathura") == 0 then
        vim.g.vimtex_view_enabled = 0 -- Snacks PDF preview remains available
      end
      vim.g.vimtex_view_automatic = 0 -- open a viewer only when requested
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_format_enabled = 0
      vim.g.vimtex_indent_enabled = 0
      vim.g.vimtex_compiler_latexmk = { continuous = 1 }
    end,
    keys = {
      { "<leader>lc", "<cmd>VimtexCompile<cr>", desc = "Toggle LaTeX compilation" },
      { "<leader>lv", "<cmd>VimtexView<cr>", desc = "View LaTeX PDF" },
      { "<leader>lp", function() require("config.latex").preview_pdf() end, desc = "Preview PDF in Neovim" },
      { "<leader>le", "<cmd>VimtexErrors<cr>", desc = "LaTeX errors" },
      { "<leader>ls", "<cmd>VimtexStop<cr>", desc = "Stop LaTeX compilation" },
    },
  },
}
