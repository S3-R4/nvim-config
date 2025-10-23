# Neovim Configuration

A portable, cross-platform Neovim configuration that works on both Windows and Linux.

## 📦 Features

- ✅ Cross-platform (Windows & Linux)
- ✅ LSP support (Pyright, Lua LS, Gopls, Rust Analyzer)
- ✅ Auto-completion with nvim-cmp
- ✅ Fuzzy finder with Telescope
- ✅ File browser with nvim-tree
- ✅ Syntax highlighting with Treesitter
- ✅ Git integration
- ✅ Dashboard
- ✅ Beautiful UI with lualine and bufferline

## 🚀 Installation

### Prerequisites

**Install Neovim 0.11+:**

- **Windows:** Download from [neovim.io](https://neovim.io) or use `scoop install neovim`
- **Linux:** `sudo apt install neovim` or build from source

### Quick Setup

#### On Windows:

```powershell
# Clone this config to Neovim's config directory
git clone https://github.com/SecurityR4t/neovim-config-v2.git $env:LOCALAPPDATA\nvim

# Or if using a portable N: drive setup (current setup):
git clone https://github.com/SecurityR4t/neovim-config-v2.git N:\Neovim
```

#### On Linux:

```bash
# Clone this config to Neovim's config directory
git clone https://github.com/SecurityR4t/neovim-config-v2.git ~/.config/nvim

# Start Neovim - plugins will auto-install
nvim
```

### First Launch

On first launch:
1. Lazy.nvim will automatically install
2. All plugins will be downloaded and installed
3. LSP servers will be installed via Mason (or install manually)
4. Treesitter parsers will compile

Just wait for everything to complete, then restart Neovim.

## 📁 Structure

```
config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── core/
│   │   ├── customPaths.lua  # Path configuration (auto-detects portable mode)
│   │   ├── options.lua      # Neovim options
│   │   └── keymaps.lua      # Key mappings
│   └── plugins/
│       ├── lazy.lua         # Plugin manager and plugin list
│       ├── lsp.lua          # LSP configuration
│       ├── appearance.lua   # UI configuration
│       └── fileBrowsing.lua # File browser setup
```

## 🔧 Configuration

### LSP Servers

Configured servers:
- **Python:** pyright
- **Lua:** lua_ls
- **Go:** gopls
- **Rust:** rust_analyzer

Install via Mason: `:Mason`

### Key Mappings

See `lua/core/keymaps.lua` for all keybindings.

## 🌐 Portable Mode (N: Drive)

The config auto-detects if it's running from `N:/Neovim/` and uses portable paths.
On other systems, it uses standard OS paths automatically.

## 📝 Notes

- **Cache/Data/State:** Auto-generated, not tracked in git
- **Plugins:** Managed by Lazy.nvim, auto-installed
- **Swap files:** Auto-cleaned after 7 days

## 🤝 Contributing

Feel free to fork and customize for your needs!

## 📄 License

MIT
