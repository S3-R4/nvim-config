return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "default",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-n>"] = false,
        ["<C-p>"] = false,
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<S-Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = {
          border = "rounded",
          scrollbar = true,
          draw = {
            gap = 2,
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 250, window = { border = "rounded" } },
        accept = { auto_brackets = { enabled = true } },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = { markdown = { "lsp", "path", "snippets", "buffer", "obsidian_tasks" } },
        providers = { obsidian_tasks = { name = "Tasks", module = "obsidian-tasks.cmp.source" } },
      },
      signature = { enabled = true },
      fuzzy = { implementation = "lua" },
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
      local function highlights()
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { link = "IncSearch" })
      end
      highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("UserCompletionHighlights", { clear = true }),
        callback = highlights,
      })
    end,
  },
}
