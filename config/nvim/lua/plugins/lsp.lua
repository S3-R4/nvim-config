-- Setup Mason
require("mason").setup()

-- Setup Mason LSPConfig to install servers
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", --[["ts_ls",]] "lua_ls", "rust_analyzer", --[["gopls"]]},
    automatic_installation = false,
})

-- Setup LSP servers with nvim-cmp capabilities
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Example: Pyright (Python)
lspconfig.pyright.setup({
    capabilities = capabilities,
})

-- Example: Lua (using lua_ls)
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },  -- Recognize "vim" in Lua
            },
        },
    },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
})

-- Example: Rust
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
})

-- Optional: Disable semantic tokens if you want
vim.lsp.handlers["textDocument/semanticTokens"] = nil

-- nvim-cmp setup
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
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- nvim-cmp integration with autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

require'cmp'.setup {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },  -- <--- add this line
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
}
 
