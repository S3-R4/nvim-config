-- Add lazy.nvim to runtime path
vim.opt.runtimepath:prepend("N:/Neovim/config/nvim/lazy/lazy.nvim")

--- Setup Lazy.nvim
require("lazy").setup({
    ---get Mason
    {
        "williamboman/mason.nvim",
        cmd = { "Mason" },  -- ensures :Mason command loads the plugin
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    ---;;;END OF get Mason
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup({})
        end,
    },
})
---;;;END OF Lazy Setup