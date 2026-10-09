# Neovim rebuild reference — 2026-10-09

This records the files in the working tree before rebuilding. It includes uncommitted edits; it is not just a record of the latest Git commit. Read the source and lockfile as authoritative when an older README or cheatsheet disagrees.

Baseline commit: `02b9e96a544e49d21d441f9b1cdbdb4490104309` (`save before installing arch`). Already modified: `lazy-lock.json`, `lua/core/options.lua`, `lua/plugins/fileBrowsing.lua`, `lua/plugins/lazy.lua`, `lua/plugins/lsp.lua`.

The config files and the local reference/ archive directory were deleted at the user's request after this inventory was made. The original snapshot remains at `/tmp/neovim-baseline-2026-10-09/neovim-baseline-2026-10-09.tar.gz`, with its checksum manifest and a copy of this document beside it. It includes the working-tree Lua config, colorscheme, lockfile, README, old cheatsheet, and .gitignore. It excludes .git, installed plugins, parsers, Mason packages, credentials, and editor state. /tmp is temporary and may be cleared at reboot; preserve the snapshot elsewhere if needed.

To inspect the original files without replacing a new config:

```sh
mkdir -p /tmp/neovim-original
tar -xzf /tmp/neovim-baseline-2026-10-09/neovim-baseline-2026-10-09.tar.gz -C /tmp/neovim-original
cd /tmp/neovim-original
sha256sum -c /tmp/neovim-baseline-2026-10-09/baseline-2026-10-09.sha256
```

This is a source-level inventory, not a runtime health check. Neovim on this machine reports v0.12.3; the config uses the Neovim 0.11+ `vim.lsp.config` / `vim.lsp.enable` APIs. Plugin-provided defaults are not exhaustively documented here.

## File layout and startup

- `init.lua`: options → keymaps → Lazy plugin specs → second bufferline setup → autopairs → LSP/completion → Markdown TOC → startup cwd change → HTML autotags.
- `lua/core/options.lua`: indentation, numbering, Neovide font/zoom, swap files and cleanup, folding.
- `lua/core/keymaps.lua`: global mappings, Copilot shortcuts, terminal split, buffer movement.
- `lua/plugins/lazy.lua`: Lazy bootstrap, plugin inventory and most plugin options.
- `lua/plugins/fileBrowsing.lua`: Telescope configuration/extensions and project.nvim options; loaded by project.nvim's config.
- `lua/plugins/lsp.lua`: Mason, LSP servers, completion and autopairs integration.
- `lua/plugins/appearance.lua`: true colors, sign column, lualine, dashboard; loaded by dashboard's VimEnter config.
- `colors/andromeda-mariana-italic-bordered.vim`: local dark colorscheme, present but not selected.
- `lazy-lock.json`: exact recorded plugin branches/commits, reproduced below.

Lazy bootstraps from the stable branch into `stdpath("data")/lazy/lazy.nvim`. If launched with a file as the first argument, VimEnter changes the global working directory to that file's parent. Otherwise startup leaves cwd alone; project detection and file-tree actions can change it later.

## Custom keybindings

Leader and local leader are **Space**. All bindings below are normal mode unless a different mode is stated. These are explicitly configured mappings; plugin and Neovim defaults are additional.

| Keys | Action |
| --- | --- |
| `<Space>tf` | Telescope find files |
| `<Space>tl` | Telescope live grep |
| `<Space>tb` | Telescope buffers; overwrites the earlier current-directory file-browser binding |
| `<Space>tp` | Telescope projects |
| `<Space>ntt` | Change cwd to current buffer's directory, then toggle NvimTree |
| `<Space>ntf` | Focus NvimTree |
| `<Space>ha` | Harpoon v1: add current file |
| `<Space>h1`, `<Space>h2` | Jump to Harpoon file 1 or 2 |
| `<Space>hm` | Telescope Harpoon marks |
| `<Space>1` … `<Space>9` | Bufferline: jump to buffer ordinal 1–9 |
| `<Space>hh`, `<Space>ll` | Move buffer left/right; accepts a numeric count, e.g. `3<Space>hh` |
| `<Space>df` | Diagnostic floating window |
| `[d`, `]d` | Previous/next diagnostic |
| `<Space>dl` | Diagnostics in location list |
| `<Space>dt` | Toggle diagnostic virtual lines |
| `<Space>Q` | Diagnostics in quickfix list and open it; uppercase Q |
| `<Space>gd` | LSP definition |
| `<Space>gt` | LSP type definition |
| `<Space>st` | Open bottom terminal split, height 15; send `cls` to shell |
| `<Space>z` | Toggle ZenMode (declared in plugin spec) |
| Insert `<Tab>` | Accept visible Copilot suggestion; otherwise insert Tab |
| Insert `<C-l>` | Accept Copilot word |
| Insert `<C-j>` | Accept Copilot line |
| Insert `<C-]>` | Dismiss Copilot suggestion |
| Insert `<C-b>` / `<C-f>` | Completion documentation scroll up/down 4 lines (LSP file's setup) |
| Insert `<C-Space>` | Trigger completion |
| Insert `<C-e>` | Abort completion |
| Insert `<CR>` | Confirm completion with `select = true` |
| Neovide normal `<C-=>` / `<C-->` | Increase/decrease GUI scale by 0.1 |
| Neovide normal `<C-0>` | Reset GUI scale to 1.0 |

Completion is configured twice. The earlier setup in lazy.lua also explicitly maps insert `<C-d>` to documentation scroll up 4 lines. The later setup in lsp.lua adds `<C-b>`, `<C-e>`, and signature-help completion. nvim-cmp may merge earlier settings; check the runtime mapping if preserving `<C-d>` matters. No custom snippet jump, rename, code-action, references, hover, save, or terminal-exit mapping is declared.

Dashboard shortcuts (dashboard buffer only): `f` find files; `b` Telescope file browser (label says Browse Projects); `r` recent files; `o` edit `$MYVIMRC`; `m` Harpoon quick menu; `KH` runs `Kbl`; `q` runs `qa`. The `Kbl` command definition is commented out, so that dashboard item has no command supplied by this config. Copilot next/previous bindings and the standalone file-browser `<Space>fb` binding are also commented out.

## Plugins and purposes

Repositories below are as declared in the config, including older repository names.

| Repository | Purpose / configured behavior |
| --- | --- |
| `folke/lazy.nvim` | Plugin manager, bootstrap |
| `nobbmaestro/nvim-andromeda` | Installed alternative theme; not selected |
| `tjdevries/colorbuddy.nvim` | Andromeda dependency |
| `rebelot/kanagawa.nvim` | Selected colorscheme `kanagawa-wave`; dimInactive=true, eager load, priority 1000 |
| `nvim-lualine/lualine.nvim` | Statusline; gruvbox theme, icons disabled; mode with window emoji, filename, diagnostics, clock, filetype, LSP progress, location |
| `nvim-tree/nvim-web-devicons` | Icons dependency |
| `akinsho/bufferline.nvim` | Numbered buffer tabs, navigation/reordering; final init.lua setup raises ordinal numbers |
| `nvimdev/dashboard-nvim` | Doom dashboard, custom ASCII header in #A82D2D, footer `~ made by S3R4`, centered content |
| `williamboman/mason.nvim` | Tool/server installer, default setup |
| `williamboman/mason-lspconfig.nvim` | Mason/LSP integration |
| `neovim/nvim-lspconfig` | LSP configurations (listed twice) |
| `nvimdev/lspsaga.nvim` | LSP UI; code-action lightbulb in sign column, no virtual-text lightbulb, no server names on code actions |
| `Aietes/esp32.nvim` | ESP32-aware clangd configuration |
| `nvim-telescope/telescope.nvim` | Fuzzy pickers (dependency) |
| `nvim-telescope/telescope-file-browser.nvim` | Ivy-style file browser, hijacks netrw |
| `nvim-lua/plenary.nvim` | Shared dependency |
| `kyazdani42/nvim-tree.lua` | File tree on right, width 35, follows focused file/cwd |
| `ahmedkhalf/project.nvim` | Project detection by LSP/root patterns and Telescope project picker |
| `ThePrimeagen/harpoon` | File bookmarks, **v1 API** (`harpoon.mark`, `harpoon.ui`); master branch |
| `hrsh7th/nvim-cmp` | Completion engine |
| `hrsh7th/cmp-nvim-lsp` | LSP completion source/capabilities |
| `hrsh7th/cmp-nvim-lsp-signature-help` | Signature-help completion source |
| `hrsh7th/cmp-buffer` | Buffer text completion |
| `hrsh7th/cmp-path` | Path completion |
| `hrsh7th/cmp-nvim-lua` | Installed but not included in the explicit completion source list |
| `L3MON4D3/LuaSnip` | Snippet engine; no custom snippet collection configured |
| `saadparwaiz1/cmp_luasnip` | Snippet completion source |
| `nvim-treesitter/nvim-treesitter` | Parser installation and highlighting using newer API |
| `windwp/nvim-ts-autotag` | Close/rename matching HTML tags, close-on-slash disabled |
| `windwp/nvim-autopairs` | Paired punctuation, integrated with completion confirmation |
| `kylechui/nvim-surround` | Surround editing, default setup, VeryLazy |
| `folke/zen-mode.nvim` | Width 65%, line numbers/relative numbers/cursorline enabled |
| `akinsho/toggleterm.nvim` | Default setup; `<Space>st` uses a native terminal rather than this plugin |
| `hedyhli/markdown-toc.nvim` | Markdown TOC (`mtoc` module, `:Mtoc`), default settings |
| `wakatime/vim-wakatime` | Activity tracking, eager load |
| `vyfor/cord.nvim` | Discord presence; atom/accent appearance, Neovim tooltip, blank workspace text, idle timeout 900000, timestamp resets on idle |
| `zbirenbaum/copilot.lua` | Auto-triggered inline suggestions and panel; built-in suggestion shortcuts disabled in favor of custom bindings |
| `zbirenbaum/copilot-cmp` | Declared dependency; no explicit setup or Copilot completion source |
| `copilotlsp-nvim/copilot-lsp` | Declared dependency for NES; no explicit NES setup/keybinding |
| `uga-rosa/ccc.nvim` | Color picker/highlighter, enabled on BufReadPre, hex/CSS RGB and custom Go RGBA parser |

The CCC custom parser handles `color.RGBA{R: ..., G: ..., B: ..., A: ...}` and `color.NRGBA{...}` with fields in that order. It converts 0–255 components, unpremultiplies RGBA when alpha > 0, and composites against the Normal background. Background cache resets on ColorScheme.

## Language support

Mason ensure_installed: **pyright, lua_ls, rust_analyzer**. `gopls` and `ts_ls` are commented out of that list; automatic_installation=false is set. Five LSP configs are enabled explicitly:

| Server | Filetypes | Settings/root details |
| --- | --- | --- |
| pyright | python | pyproject.toml, setup.py, setup.cfg, requirements.txt, Pipfile, .git |
| lua_ls | lua | Standard Lua root markers; recognizes global `vim` |
| gopls | go, gomod, gowork, gotmpl | go.work/go.mod/.git; placeholders, unimported completion, unusedparams/shadow analyses, staticcheck |
| rust_analyzer | rust | Cargo.toml, rust-project.json, .git |
| clangd via esp32.nvim | c, cpp, objc, objcpp, cuda, ino | Plugin supplies ESP-IDF-aware command/root/compile-commands setup; merged cmp capabilities |

All receive nvim-cmp capabilities. The config sets `vim.lsp.handlers["textDocument/semanticTokens"] = nil`; this alone is not evidence that semantic tokens are disabled at runtime.

Treesitter parser list: **go, lua, python, rust, html, typescript, javascript, tsx, json**. Setup calls `ts.install(...):wait()` and FileType calls `pcall(vim.treesitter.start, ...)`. Despite an indentation comment, the active code only starts highlighting; it does not configure a Treesitter indentation expression. C/C++ parsers are not in the explicit list.

Completion sources in the later LSP setup: nvim_lsp, nvim_lsp_signature_help, luasnip, buffer, path. LuaSnip expands server-provided snippets; autopairs hooks `confirm_done`.

## Editor, files, and navigation settings

- Absolute + relative line numbers; expand tabs to spaces; shiftwidth/tabstop=4.
- True colors and permanently reserved sign column are set by appearance.lua.
- Neovide only: `JetBrainsMono Nerd Font:h10`, scale=1.0, normal-mode zoom bindings.
- Swap enabled; updatecount=100; directory `stdpath('data')/swap//`. Startup creates it and deletes .swp files older than 7 days using PowerShell on Windows or find on Unix.
- FileType folding: parser available → expression folding via `vim.treesitter.foldexpr()`; otherwise syntax folding. No custom fold-level setting.
- Telescope grep: rg with filename/line/column, smart case, hidden files, `--no-ignore-vcs`. Ignore patterns: node_modules, .git/, target, build, `%.lock`.
- Telescope file search: explicit `fd --type f --strip-cwd-prefix`, plus hidden=true. Because find_command is supplied, hidden-file inclusion depends on the actual fd invocation; there is no explicit `--hidden` in that command.
- File-browser extension: ivy, hijack_netrw=true, hidden=true. The overwritten current-buffer browser callback additionally requested grouped=true, select_buffer=true, respect_gitignore=false.
- Project roots: .git, Makefile, package.json; detect by LSP then patterns; global silent cwd changes; hidden projects shown; null-ls ignored. Excludes ~/.cargo/*, ~/AppData/*, node_modules, .git, target, build.
- External commands explicitly referenced include git, rg, fd, language-server executables, and PowerShell/find. Treesitter parser compilation also requires a working compiler/toolchain. Copilot, WakaTime and Discord features require their own external setup, not captured here.

## Discrepancies to remember during rebuilding

- `<Space>tb` is buffers, not the file-browser callback earlier in keymaps.lua. The old cheatsheet lists both without explaining the override.
- Dashboard KH calls undefined `Kbl`; terminal clear uses Windows `cls` even on Unix.
- Kanagawa setup says theme=lotus, but the explicit colorscheme command selects **wave**. Andromeda and the custom local theme are not active selections. Rose Pine/Catppuccin specs are commented out.
- bufferline, autopairs, autotag, Mason/Mason-LSPConfig, and completion have repeated setup paths; nvim-lspconfig has duplicate specs. Preserve the intended behavior rather than copying accidental duplication.
- nvim-tree uses `requires` instead of Lazy's `dependencies`; devicons is also supplied elsewhere. Some options are legacy and their runtime effect depends on the locked version.
- README mentions `core/customPaths.lua` and automatic N: portable-path detection, but that file/logic is absent from the current source.
- README claims Git integration; there is no dedicated Git editing/signs plugin in the active specs.
- `snacks.nvim` appears in the lockfile but has no explicit spec in these config files; a lock entry alone does not establish that it is active.
- .gitignore contains several concatenated or malformed-looking patterns; preserve the archive independently of assumptions about Git tracking.

## Exact lockfile versions

The table records the lockfile, not verified installed checkout versions.

| Plugin | Branch | Commit |
| --- | --- | --- |
| LuaSnip | master | `a62e1083a3cfe8b6b206e7d3d33a51091df25357` |
| bufferline.nvim | main | `655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3` |
| ccc.nvim | main | `9d1a256e006decc574789dfc7d628ca11644d4c2` |
| cmp-buffer | main | `b74fab3656eea9de20a9b8116afa3cfc4ec09657` |
| cmp-nvim-lsp | main | `cbc7b02bb99fae35cb42f514762b89b5126651ef` |
| cmp-nvim-lsp-signature-help | main | `fd3e882e56956675c620898bf1ffcf4fcbe7ec84` |
| cmp-nvim-lua | main | `e3a22cb071eb9d6508a156306b102c45cd2d573d` |
| cmp-path | main | `c642487086dbd9a93160e1679a1327be111cbc25` |
| cmp_luasnip | master | `98d9cb5c2c38532bd9bdb481067b20fea8f32e90` |
| colorbuddy.nvim | master | `8b968581e5c19d22a861d5f3fe5dbd83394fa681` |
| copilot-cmp | master | `15fc12af3d0109fa76b60b5cffa1373697e261d1` |
| copilot-lsp | main | `1b6d8273594643f51bb4c0c1d819bdb21b42159d` |
| copilot.lua | master | `7e9c269bf40dea86b44e64bd746f1808e991e419` |
| cord.nvim | master | `0be090969e978f7442870ef227e09eff7bf3480d` |
| dashboard-nvim | master | `f787e3462c2ee2b6117b17c1aa4ddf66cb6f57fe` |
| esp32.nvim | main | `112b4b052b7d3ccd361a53e683808435a4ecaf5a` |
| harpoon | master | `1bc17e3e42ea3c46b33c0bbad6a880792692a1b3` |
| kanagawa.nvim | master | `bb85e4bfc8d89b0e62c8fa53ccdd13d12e2f77b3` |
| lazy.nvim | main | `306a05526ada86a7b30af95c5cc81ffba93fef97` |
| lspsaga.nvim | main | `3e33a6a6c5d379f3d4fae77fae6b53b762a0a30f` |
| lualine.nvim | master | `131a558e13f9f28b15cd235557150ccb23f89286` |
| markdown-toc.nvim | main | `869af35bce0c27e2006f410fa3f706808db4843d` |
| mason-lspconfig.nvim | main | `eaa34887d444cb002e1b165fac399ae4bbc771f7` |
| mason.nvim | main | `8e921c2b68571e978db5d4d3fef9c9a7f8755473` |
| nvim-andromeda | master | `363a0766713c1381b1b6b3a46d22ac6fd5664569` |
| nvim-autopairs | master | `7b9923abad60b903ece7c52940e1321d39eccc79` |
| nvim-cmp | main | `a1d504892f2bc56c2e79b65c6faded2fd21f3eca` |
| nvim-lspconfig | master | `8f7e64066e2641d5e7d494962a9c7051e3d38dd5` |
| nvim-surround | main | `2e93e154de9ff326def6480a4358bfc149d5da2c` |
| nvim-tree.lua | master | `f9bfc0059eca24546b69a7006110463da4808f8f` |
| nvim-treesitter | main | `4916d6592ede8c07973490d9322f187e07dfefac` |
| nvim-ts-autotag | main | `88c1453db4ba7dd24131086fe51fdf74e587d275` |
| nvim-web-devicons | master | `2795c26c916bb3c57dde308b82be51971fa92747` |
| plenary.nvim | master | `74b06c6c75e4eeb3108ec01852001636d85a932b` |
| project.nvim | main | `8c6bad7d22eef1b71144b401c9f74ed01526a4fb` |
| snacks.nvim | main | `882c996cf28183f4d63640de0b4c02ec886d01f2` |
| telescope-file-browser.nvim | master | `3610dc7dc91f06aa98b11dca5cc30dfa98626b7e` |
| telescope.nvim | master | `9377230aa5305d9e9aca4ed8dadf1070fb4aa9fc` |
| toggleterm.nvim | main | `50ea089fc548917cc3cc16b46a8211833b9e3c7c` |
| vim-wakatime | master | `24495fb7cc9613eaf0ce45540fb8d096a30d08e9` |
| zen-mode.nvim | main | `8564ce6d29ec7554eb9df578efa882d33b3c23a7` |
