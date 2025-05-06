-- Add lazy.nvim to runtime path
-- vim.opt.runtimepath:prepend("N:/Neovim/config/nvim/lazy/lazy.nvim")

-- sets the Path to the custom location in my case its N:/Neovim/.../...
-- Set the path to where lazy.nvim should live (uses portable XDG override)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

--Bootstrap / Install lazy.nvim if it doesn't exist
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Add lazy.nvim to the runtime path
vim.opt.runtimepath:prepend(lazypath)


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

    --- nvim-telescope
    {   
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    ---;;;END OF nvim-telescope

    --- dashboard-nvim
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('plugins.appearance').setup_dashboard()
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'} }
    },
    
    ---;;;END OF dashboard-nvim 

})
---;;;END OF Lazy Setup