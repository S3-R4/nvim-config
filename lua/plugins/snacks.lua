local settings = require("config.settings")
return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      picker = { enabled = true, icons = { files = { enabled = false } } },
      explorer = { enabled = true },
      image = { enabled = settings.features.image },
      scroll = { enabled = settings.features.scroll, animate = { duration = { step = 8, total = 120 } } },
      dashboard = {
        enabled = true,
        preset = {
          header = "n e o v i m",
          keys = {
            { key = "f", desc = "Files", action = function() Snacks.picker.files() end },
            { key = "g", desc = "Search", action = function() Snacks.picker.grep() end },
            { key = "p", desc = "Projects", action = function() Snacks.picker.projects() end },
            { key = "r", desc = "Recent", action = function() Snacks.picker.recent() end },
            { key = "n", desc = "Notes", action = ":Notes" },
            { key = "c", desc = "Config", action = ":ConfigSettings" },
            { key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = { { section = "header", padding = 1 }, { section = "keys", gap = 1, padding = 1 } },
      },
    },
    keys = {
      { "<leader>tf", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>tl", function() Snacks.picker.grep() end, desc = "Search project" },
      { "<leader>tb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>tp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>tr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<leader>ts", function() Snacks.picker.lines() end, desc = "Search buffer with preview" },
      { "<leader>tw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Search word or selection" },
      { "<leader>ntt", function() Snacks.explorer() end, desc = "File explorer" },
      { "<leader>ntf", function() Snacks.explorer.reveal() end, desc = "Reveal file in explorer" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Close buffer" },
      { "<leader>z", function() Snacks.zen() end, desc = "Zen mode" },
      { "<leader>ut", function() Snacks.picker.colorschemes() end, desc = "Compare themes" },
      { "<leader>us", function()
        if Snacks.scroll.enabled then Snacks.scroll.disable() else Snacks.scroll.enable() end
      end, desc = "Toggle smooth scrolling" },
    },
  },
}
