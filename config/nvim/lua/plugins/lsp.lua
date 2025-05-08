-- Setup Mason
require("mason").setup()

-- Setup Mason LSPConfig to install servers
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "ts_ls", "lua_ls", "rust_analyzer", "gopls"}, -- updated to typescript-language-server
    automatic_installation = false,  -- automatically install the LSP servers
})

-- Setup LSP servers
local lspconfig = require("lspconfig")

-- Example: Pyright (Python)
lspconfig.pyright.setup({})

-- -- -- -- Example: typescript-language-server (TypeScript/JavaScript)
-- -- -- lspconfig.tsserver.setup({
-- -- --     -- you can configure this LSP more specifically here if needed
-- -- -- })

-- Example: Lua (using lua_ls)
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },  -- Recognize "vim" in Lua
            },
        },
    },
})

-- Example: Rust
lspconfig.rust_analyzer.setup({})

-- Example: Golang
lspconfig.gopls.setup({})


local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Accept suggestion
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },  -- For snippets
    { name = 'buffer' },   -- For words in buffer
    { name = 'path' },     -- For file paths
  })
})