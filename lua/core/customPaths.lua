-- Cross-platform portable paths (Windows & Linux compatible)
-- This file is now optional - Neovim will use system defaults
-- Only set custom paths if XDG variables are already set (for portable installations)

-- Detect if running in a portable setup (N: drive or custom location)
local is_portable = vim.fn.isdirectory('N:/Neovim/config') == 1

if is_portable then
    -- Portable mode: Use N: drive paths (current Windows setup)
    vim.env.XDG_CONFIG_HOME = "N:/Neovim/config"
    vim.env.XDG_DATA_HOME = "N:/Neovim/data"
    vim.env.XDG_CACHE_HOME = "N:/Neovim/cache"
    vim.env.XDG_STATE_HOME = "N:/Neovim/state"
else
    -- Standard mode: Use system defaults
    -- Windows: ~\AppData\Local\nvim, ~\AppData\Local\nvim-data
    -- Linux: ~/.config/nvim, ~/.local/share/nvim
    -- These will be auto-detected by vim.fn.stdpath()
    -- No need to set anything - Neovim handles it
end
