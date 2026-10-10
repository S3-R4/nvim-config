return {
  { "kylechui/nvim-surround", event = "VeryLazy", version = "*", opts = {} },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function map(key, action, desc)
          vim.keymap.set("n", key, action, { buffer = buf, desc = desc })
        end
        map("]h", function() gs.nav_hunk("next") end, "Next Git hunk")
        map("[h", function() gs.nav_hunk("prev") end, "Previous Git hunk")
        map("<leader>gp", gs.preview_hunk, "Preview Git hunk")
        map("<leader>gs", gs.stage_hunk, "Stage Git hunk")
        map("<leader>gb", gs.blame_line, "Git blame")
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})
      vim.api.nvim_create_user_command("InstallParsers", function()
        require("nvim-treesitter").install({ "go", "gomod", "gowork", "java", "c", "cpp", "sql", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "latex", "html", "yaml", "json", "bash" })
      end, { desc = "Install this configuration's parsers asynchronously" })
      local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
      local function attach(buf)
        if vim.bo[buf].buftype ~= "" or vim.b[buf].snacks_bigfile then return end
        -- Keep VimTeX's syntax engine for TeX editing.
        if vim.bo[buf].filetype == "tex" then return end
        local ok = pcall(vim.treesitter.start, buf)
        if ok then
          for _, win in ipairs(vim.fn.win_findbuf(buf)) do
            vim.wo[win].foldmethod = "expr"
            vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end
      end
      vim.api.nvim_create_autocmd("FileType", { group = group, callback = function(args) attach(args.buf) end })
      attach(vim.api.nvim_get_current_buf())
    end,
  },
}
