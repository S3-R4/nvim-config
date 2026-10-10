local settings = require("config.settings")
return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      {
        "nvim-mini/mini.icons",
        version = "*",
        opts = {
          filetype = {
            go = { glyph = "", hl = "MiniIconsAzure" },
            java = { glyph = "", hl = "MiniIconsOrange" },
          },
          file = {
            ["go.mod"] = { glyph = "", hl = "MiniIconsAzure" },
            ["go.sum"] = { glyph = "", hl = "MiniIconsAzure" },
          },
        },
      },
    },
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      picker = {
        enabled = true,
        icons = { files = { enabled = true } },
        sources = {
          explorer = { layout = { layout = { position = "right" } } },
        },
      },
      explorer = { enabled = true },
      zen = {
        toggles = { dim = false, git_signs = false, mini_diff_signs = false },
        win = { backdrop = { transparent = true, bg = "#000000", blend = 15 } },
        on_open = function(win)
          require("config.zen").open(win)
          if Snacks.scroll.enabled then Snacks.scroll.check(win.win) end
        end,
        on_close = function() require("config.zen").close() end,
      },
      image = { enabled = settings.features.image },
      scroll = {
        enabled = settings.features.scroll,
        animate = { duration = { step = 14, total = 280 }, easing = "outQuad" },
        animate_repeat = { duration = { step = 10, total = 140 } },
      },
      dashboard = {
        enabled = true,
        width = 90,
        formats = { header = { "%s", align = "left" } },
        preset = {
          header = [[


                                                                          @@@@@
              @@@@@@@@@                                   @@@       @@@@@@@@@@@@@
                @@@@@@@@@                                  @@@@@@@@@@@@@@@@@@@@@@
                  @@@@@@@                                   @@@@@@@@@@@@@@@@
                  @@@@@@
                  @@@@@@          @@@@@@                                       @@
                  @@@@@@    @@@@@@@@@@@@@@            @@                @@@@@@@@@@@@
                  @@@@@@@@@@@@@@@@@@@@@@@@@           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@         @@@@@@@@@@@@@@     @@@@@@@@@            @@@@@@@@@@@@@@@@@@@@  @@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@         @@@@@@@                @@@@@@@@@            @@@@@@@@
     @@@@@@@@@@@@@@@@@@         @@@@@                                       @@@@@@@
      @@@@@@@@    @@@@@       @@@@@                                        @@@@@@@
                  @@@@@      @@@                                          @@@@@@@
                  @@@@@                                                 @@@@@@@@
                  @@@@@                                               @@@@@@@@
                  @@@@@                                              @@@@@@@
                  @@@@@@        @@@@@@@@@                          @@@@@@@
                   @@@@@@@@@@@@@@@@@@@@@@@                      @@@@@@@@
                    @@@@@@@@@@@@@@@@@@@@@                     @@@@@@@
                        @@@@@@@@                           @@@@@@
                                                         @@@@


]],
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
        sections = {
          { section = "header", padding = 1 },
          function(self)
            local items = {}
            for _, key in ipairs(self.opts.preset.keys) do
              local item = vim.deepcopy(key)
              item.text = {
                { ("%-12s"):format(item.desc), hl = "desc" },
                { ("[%s]"):format(item.key), hl = "key" },
              }
              item.align = "center"
              items[#items + 1] = item
            end
            return items
          end,
        },
      },
    },
    keys = {
      { "<ScrollWheelDown>", function() return require("config.scroll").key(1) end,
        mode = { "n", "i", "x" }, expr = true, desc = "Smooth mouse scroll down" },
      { "<ScrollWheelUp>", function() return require("config.scroll").key(-1) end,
        mode = { "n", "i", "x" }, expr = true, desc = "Smooth mouse scroll up" },
      { "<leader>tf", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>tl", function() Snacks.picker.grep() end, desc = "Search project" },
      { "<leader>tb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader><Space>", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>tp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>tr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<leader>ts", function() Snacks.picker.lines() end, desc = "Search buffer with preview" },
      { "<leader>tw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Search word or selection" },
      { "<leader>ntt", function() Snacks.explorer() end, desc = "File explorer" },
      { "<leader>ntf", function()
        local explorer = Snacks.picker.get({ source = "explorer" })[1]
        if explorer then explorer:focus("list") else Snacks.explorer() end
      end, desc = "Focus file explorer" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Close buffer" },
      { "<leader>z", function() Snacks.zen() end, desc = "Zen mode" },
      { "<leader>ut", function() Snacks.picker.colorschemes() end, desc = "Compare themes" },
    },
  },
}
