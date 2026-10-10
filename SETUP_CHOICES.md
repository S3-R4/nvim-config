# Neovim rebuild choices

Recorded: 2026-10-10. Implementation requested and built on 2026-10-10. See README.md for use, dependencies, and validation.

## Requirements and preferences

- Main language: Go. Also Java, C/C++, SQL, and other languages as needed.
- Keep lazy.nvim and Mason.
- Minimal UI, fast startup, reliable goto definition, minimalist dashboard, smooth scrolling.
- Edit Markdown notes and personal todos, with inline images and math.
- Write LaTeX/TikZ notes with compilation and PDF preview.
- Terminal: Ghostty.
- Font: Iosevka. Configure the terminal font when implementation is authorized; final variant remains to be chosen.
- Use the same configuration on desktop and laptop. Remote editing should run Neovim, plugins, language servers, and build tools on the desktop to reduce laptop work; remote-ssh.nvim / rnvim is selected as an optional external client. No tmux. Disable it using remote.enabled=false or NVIM_REMOTE_DISABLED=1; local nvim always stays local.
- No automatic formatting, format-on-save, or automatic import rewriting. Preserve manually written layout. Do not add Conform or formatter integrations. Language-server formatting capabilities need not be used.
- User will update Neovim; the configuration targets that update and imposes no special VimTeX version restriction. The initially installed/locked revision remains v2.17 until `:Lazy update vimtex` is run after the Neovim update.
- Space remains leader and local leader.
- REBUILD_REFERENCE.md contains mnemonic/keybinding inspiration. Reuse or change individual mappings intentionally; exact preservation is not required.
- Harpoon is not used and is excluded.

## Selected editor plugins

| Plugin | Purpose | Reference |
| --- | --- | --- |
| folke/lazy.nvim | Plugin manager | https://github.com/folke/lazy.nvim |
| rebelot/kanagawa.nvim | Colorscheme | https://github.com/rebelot/kanagawa.nvim |
| harshrajsachan/omni.nvim | Compare against Kanagawa; only one theme active at a time | https://github.com/harshrajsachan/omni.nvim |
| catppuccin/nvim | Third theme available for comparison | https://github.com/catppuccin/nvim |
| nvim-lualine/lualine.nvim | Compact statusline | https://github.com/nvim-lualine/lualine.nvim |
| nvim-treesitter/nvim-treesitter | Parsers, highlighting, folding | https://github.com/nvim-treesitter/nvim-treesitter |
| lewis6991/gitsigns.nvim | Git changes and hunk operations | https://github.com/lewis6991/gitsigns.nvim |
| folke/snacks.nvim | Selected modules listed below | https://github.com/folke/snacks.nvim |
| mason-org/mason.nvim | Development-tool and server installation | https://github.com/mason-org/mason.nvim |
| mason-org/mason-lspconfig.nvim | Mason/LSP integration | https://github.com/mason-org/mason-lspconfig.nvim |
| neovim/nvim-lspconfig | Configurations for native Neovim LSP | https://github.com/neovim/nvim-lspconfig |
| saghen/blink.cmp | Completion | https://github.com/saghen/blink.cmp |
| mfussenegger/nvim-jdtls | Java integration | https://github.com/mfussenegger/nvim-jdtls |
| tpope/vim-dadbod | SQL query execution | https://github.com/tpope/vim-dadbod |
| kristijanhusak/vim-dadbod-ui | Database interface | https://github.com/kristijanhusak/vim-dadbod-ui |
| obsidian-nvim/obsidian.nvim | Vaults, links, backlinks, templates, daily notes, checkboxes | https://github.com/obsidian-nvim/obsidian.nvim |
| mariocesar/beside.nvim | Live Markdown/document preview in a synchronized split | https://github.com/mariocesar/beside.nvim |
| folke/todo-comments.nvim | TODO/FIXME comments in code | https://github.com/folke/todo-comments.nvim |
| lervag/vimtex | LaTeX compilation, editing, PDF synchronization | https://github.com/lervag/vimtex |
| kylechui/nvim-surround | Surround editing | https://github.com/kylechui/nvim-surround |

## Selected Snacks modules

- dashboard: minimalist starting screen.
- picker: files, search, buffers, projects, LSP results.
- explorer: file tree.
- scroll: smooth scrolling.
- bigfile: reduce expensive features in large files.
- quickfile: show opened files before loading plugins.
- zen: focused editing.
- image: inline images and rendered math in Ghostty.

Snacks terminal was not selected. A native terminal remains available without a plugin.

## Selected language servers

| Server | Language | Notes |
| --- | --- | --- |
| gopls | Go | Configure project roots and navigation. |
| clangd | C/C++ | Supply project compilation information, usually compile_commands.json. |
| JDT LS | Java | Use nvim-jdtls as the single Java startup path; avoid duplicate clients. |
| SQL server, implementation undecided | SQL | Choose after identifying database/dialect and required features. |
| texlab | LaTeX | Language assistance; VimTeX owns compilation and PDF synchronization. |

lua_ls was not selected. Additional servers require a later decision.

## Notes, todos, and rendering

- Use obsidian.nvim for note management and checkbox toggling.
- Personal todos may be ordinary Markdown task lists (- [ ] / - [x]); this is a file format, not an extra plugin.
- todo-comments.nvim searches code comments, not a personal task database.
- Exclude markdown-preview.nvim: no separate browser preview requested.
- Exclude render-markdown.nvim at the user's request.
- Important distinction: Snacks Image renders images/math; it does not replace render-markdown's styling of headings, tables, code blocks, and callouts. Beside now provides a separate rendered document preview; its output depends on the chosen external renderer and is not full Obsidian rendering parity.
- Ghostty supplies compatible terminal graphics support; rendering still requires the appropriate parsers and external conversion tools. Check installed dependencies during implementation.
- Full LaTeX/TikZ output uses the TeX compiler and PDF viewer. Inline math rendering is not a substitute for compiling complete documents.

## External tools selected or required

- A TeX distribution with required LaTeX/TikZ packages.
- latexmk.
- PDF viewer with synchronization support; Zathura is the proposed choice, not yet finalized.
- Image conversion dependencies for Snacks Image, including ImageMagick as required by its documentation.
- Glow v2.1.1 is built in bin/glow for Beside; these architecture-specific binaries are ignored by Git.
- git, ripgrep, and relevant parser-build tools; verify actual requirements at implementation time.

## Exclusions and implementation boundaries

- No Conform, automatic formatting, or automatic import cleanup.
- No render-markdown.nvim, markdown-preview.nvim, which-key.nvim, Harpoon, or bufferline selected.
- No additional dashboard, picker, explorer, smooth-scroll plugin, or LSPSaga.
- No separate snippet engine selected; begin with Blink/native snippet support.
- Do not inherit Discord presence, WakaTime, Copilot, or other historical plugins without a new selection.
- Keep configuration paths single and explicit; avoid duplicate setup calls.
- Follow current plugin loading requirements. Do not force lazy loading where unsupported (notably Treesitter and VimTeX).
- Keep synchronous installation/compilation out of normal startup; measure startup after implementation.

## Machine settings and remaining choices

- Extra task manager remains undecided: Markdown checkboxes alone, Obsidian Tasks, or Dooing. Basic toggling is available without a configured vault.
- Identify SQL database/dialect and select its language server.
- Choose notes/vault and todo locations.
- Finalize PDF viewer and confirm the Neovim update.
- Keymaps are implemented and documented in README.md; REBUILD_REFERENCE.md remains untouched.

## Additional selected plugins and remaining candidates

Wayfinder, Fugitive + Flog, add-subtract-ex, and Goplexity were explicitly selected during implementation:

- error311/wayfinder.nvim: guided code exploration and saved trails; overlaps existing LSP navigation but adds a combined exploration workflow.
- rbong/vim-flog: Git history graph; installed together with its dependency tpope/vim-fugitive; both load on demand.
- DRoma82/add-subtract-ex.nvim: manual booleans/operator/letter changes via Ctrl-A/Ctrl-X. Configured with sign_aware=true to preserve native signed-number behavior.
- sjclayton/goplexity.nvim: heuristic complexity hints, not verified complexity proofs. Installed, but hints stay off and the plugin stays unloaded until toggled with Space tc. Do not rely on the annotations for correctness.
- snapwich/obsidian-tasks.nvim: task queries/dashboards across Markdown vault files. Distinct from ordinary Obsidian checkbox toggling and code TODO comments.
- atiladefreitas/dooing: separate JSON-backed task manager. Compare with the Markdown-vault task workflow before choosing; not a drop-in interface for existing vault tasks.
- nacro90/numb.nvim: line-number previews. User also wants word-based previews; native incremental search and Snacks current-buffer/project search already address that without another plugin.
- Amansingh-afk/milli.nvim: optional animated dashboard decoration. Compatible with Snacks; evaluate animation/redraw overhead and battery cost rather than assuming it is slow.
- GNITOAHC/remote-ssh.nvim: currently an external rnvim CLI using SSH and Neovim remote UI, not a Lazy plugin. Selected. Client built from source revision 4c35ad4a4ad9a1d9be68cffe04c3ed76814c26f3. Launcher arguments and disable gates tested; real SSH, reconnection, graphics and remote PDF viewing remain untested until a host is supplied. Automatic config sync is forced off.

## Implementation checks

- 26 Lazy plugins configured and locked; selected parsers and gopls/clangd/JDT LS/texlab installed.
- Go definition requests and mapped Snacks jump passed; one Java client initialized.
- C server attachment and unchanged saves passed; VimTeX compiled a LaTeX/TikZ fixture.
- Go and Markdown saved without content changes; Obsidian frontmatter rewriting and UI styling disabled.
- Beside rendered through Glow; three theme families switched successfully.
- Real terminal startup reached first screen in approximately 20 ms with warm desktop caches; laptop/cold-start performance not measured.
- Shared defaults: lua/config/settings.lua. Machine overrides: ignored lua/config/local.lua, created with :ConfigLocal. Vault and SQL server can change through per-launch environment overrides; remote hosts can change through launcher arguments.
- Zathura and Iosevka are missing. Ghostty currently uses JetBrains Mono. terminal/ghostty-font.conf supplies the requested Iosevka setting.
