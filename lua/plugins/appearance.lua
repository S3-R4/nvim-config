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
    dependencies = { "nvim-mini/mini.icons" },
    keys = (function()
      local keys = {}
      for index = 1, 9 do
        local position = index
        keys[#keys + 1] = {
          "<leader>" .. position,
          function()
            require("lualine").tabline()
            require("lualine.components.buffers").buffer_jump(position, "!")
          end,
          desc = "Switch to file " .. position,
        }
      end
      return keys
    end)(),
    config = function(_, opts)
      require("mini.icons").mock_nvim_web_devicons()
      require("lualine").setup(opts)
    end,
    opts = {
      options = {
        theme = function() return require("config.statusline").theme() end,
        icons_enabled = true,
        globalstatus = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", { "diff", colored = true } },
        lualine_c = {
          { "filename", path = 1 },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn", "info", "hint" },
            update_in_insert = true,
            always_visible = false,
            symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
          },
        },
        lualine_x = {
          { "filetype", icon_only = true, separator = "|" },
          { "fileformat", separator = "|" },
          { "lsp_status", show_name = true },
        },
        lualine_y = { { "datetime", style = "%Y-%m-%d %H:%M" } },
        lualine_z = { "location" },
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            mode = 2,
            show_filename_only = true,
            hide_filename_extension = false,
            show_modified_status = true,
          },
        },
        lualine_z = {},
      },
    },
  },
}
