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
    --- APPEARANCE STUFF
    ---installing andromeda color theme
    {
        "nobbmaestro/nvim-andromeda",
        dependencies = { "tjdevries/colorbuddy.nvim" },
    },
    ---;;;END OF andromeda color theme
  
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    ---;;;END OF APPEARANCE STUFF

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

    --- harpoon 
    {
        'ThePrimeagen/harpoon',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("harpoon").setup()
        end
    },
    ---;;;END OF harpoon 

    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function() 
            require("bufferline").setup{
                options = {
                    numbers = function(opts)
                        return tostring(opts.ordinal)
                    end,
                }
            }   

        end,
    },

    {
        'kyazdani42/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.g.nvim_tree_respect_buf_cwd = 1

            require("nvim-tree").setup({
                    update_cwd = true,
                    respect_buf_cwd = true,
                    update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                view = {
                    side = "right",
                    width = 35,

                },})
            end
    },

    --- project-nvim
    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('plugins.fileBrowsing').setup()
          end
    },
    ---;;;END OF project-nvim     
        -- Completion engine + sources
    {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
        local cmp = require('cmp')
        cmp.setup({
        snippet = {
            expand = function(args)
            require('luasnip').lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
        }),
    })
    end
},

    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
        event = "InsertEnter",
    }, -- for html auto Tag complete


    -- LSP
    { 'neovim/nvim-lspconfig' },
    -- (Optional) prettier UI for LSP actions
    { 
        'nvimdev/lspsaga.nvim', 
        event = 'LspAttach',
        config = function()
            require('lspsaga').setup({
                lightbulb = {
                    enable = true,           -- Keep lightbulb feature enabled
                    sign = true,             -- Show lightbulb in sign column (left of line numbers)
                    virtual_text = false,    -- Disable virtual text lightbulb (the extra one you don't want)
                },
                code_action = {
                    show_server_name = false,
                    extend_gitsigns = false,
                },
            })
        end
    },
    ---;;; END OF LSP

    {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
        highlight = { enable = true },      -- enable syntax highlighting
        indent = { enable = true },         -- enable indentation
        ensure_installed = { "go", "lua", "python", "rust", "html", "typescript", "javascript", "tsx", "json"}, -- add languages you use
        -- autotag = {enable = true}, -- for html autotags
        })
    end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true, -- or use config = function() require("nvim-autopairs").setup {} end
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    { 'wakatime/vim-wakatime', lazy = false },

    {'akinsho/toggleterm.nvim', version = "*", config = true},

    {
        "hedyhli/markdown-toc.nvim",
        ft = "markdown",  -- Lazy load on markdown filetype
        cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
        opts = {
        -- Your configuration here (optional)
        },
    },
    {
        'vyfor/cord.nvim',
        build = ':Cord update',
        config = function()
            require('cord').setup({
                display = {
                    theme = 'atom',
                    flavor = 'accent',
                },
                editor = {
                    tooltip = 'Neovim',
                },
                timestamp = {
                    reset_on_idle = true,
                },
                idle = {
                    enabled = true,
                    timeout = 900000,
                },
                text = {
                    workspace = '',
                },
            })
        end,
        -- opts = {}
    },
    ---;;; setup for Github Copilot
    {
        "zbirenbaum/copilot.lua",
        dependencies = {
            "zbirenbaum/copilot-cmp",
            "copilotlsp-nvim/copilot-lsp", -- for NES functionality
        },
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = false,      -- disable built-in keymaps
                    accept_word = false,
                    accept_line = false,
                    next = false,
                    prev = false,
                    dismiss = false,
                },
            },
            panel = { enabled = true },
        })
        end,
  },


})
---;;;END OF Lazy Setup
