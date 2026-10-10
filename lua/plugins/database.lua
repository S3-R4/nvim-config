return {
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = { "tpope/vim-dadbod" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 0
      vim.g.dbs = require("config.settings").sql.connections
      vim.g.db_ui_auto_execute_table_helpers = 0
    end,
    keys = { { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Database interface" } },
  },
}
