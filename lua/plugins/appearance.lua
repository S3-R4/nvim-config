return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = { dimInactive = false },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      local theme = require("config.settings").theme
      if theme:match("^kanagawa") then vim.cmd.colorscheme(theme) end
    end,
  },
  {
    "harshrajsachan/omni.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local theme = require("config.settings").theme
      if theme:match("^omni") then vim.cmd.colorscheme(theme) end
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = require("config.settings").features.catppuccin,
    lazy = false,
    priority = 1000,
    opts = { flavour = "mocha" },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      local theme = require("config.settings").theme
      if theme:match("^catppuccin") then vim.cmd.colorscheme(theme) end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = { theme = "auto", icons_enabled = false, globalstatus = true, component_separators = "", section_separators = "" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "filename", path = 1 }, "diagnostics" },
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = { "location" },
      },
    },
  },
}
