return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 250 },
        accept = { auto_brackets = { enabled = false } },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = { markdown = { "lsp", "path", "snippets", "buffer", "obsidian_tasks" } },
        providers = { obsidian_tasks = { name = "Tasks", module = "obsidian-tasks.cmp.source" } },
      },
      signature = { enabled = true },
      fuzzy = { implementation = "lua" },
    },
  },
}
