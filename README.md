# Neovim

A custom Lazy configuration for Go, Java, C/C++, SQL, Markdown notes, and LaTeX. Space is the leader and local leader. Kanagawa Wave is the default theme; Omni and Catppuccin are available through `Space ut`.

## Settings

Use `:ConfigSettings` for shared preferences. Use `:ConfigLocal` to create and edit `lua/config/local.lua` for this machine. That file is ignored by Git. Restart Neovim after editing either settings file.

```lua
return {
  notes = { vault = "/path/to/vault" },
  sql = {
    server = "sqls", -- optional; leave empty until you choose a server
    connections = {
      { name = "development", url = vim.env.DEV_DATABASE_URL },
    },
  },
  remote = { enabled = true, host = "desktop" },
  latex = { viewer = "zathura" },
}
```

Paths and hosts are not tied to this computer. For a different vault or SQL server on one launch:

```sh
NVIM_NOTES_VAULT=/another/vault nvim
NVIM_SQL_SERVER=sqls nvim
```

Environment overrides take priority over saved settings. Database connections can also be added interactively with `:DBUIAddConnection`. SQL LSP is disabled until a server is selected; Dadbod query execution is available independently. The matching database command-line client must be installed.

## Installation and dependencies

Lazy installs missing plugins on a fresh machine. `lazy-lock.json` records the tested revisions. Normal startup does not check for updates, download language servers, or compile parsers.

- `:InstallServers` installs gopls, clangd, JDT LS, texlab, and the selected SQL server through Mason.
- `:InstallParsers` installs the chosen Treesitter parsers asynchronously. Reopen a buffer after installing its parser.
- `:ConfigHealth` checks external tools. Plugin-specific checks are available with `:checkhealth`.
- Go requires Go; JDT LS requires Java 21 or newer. C/C++ navigation benefits from a project `compile_commands.json`.
- VimTeX requires a TeX distribution, `latexmk`, and a PDF viewer. Zathura is the current default. TikZ requires the corresponding TeX packages.
- Snacks Image uses ImageMagick and a supported terminal, plus parsers and TeX tools for math. Ghostty supports the required graphics protocol. Actual display must be checked in Ghostty; a headless test cannot verify it.
- Beside uses Glow for live Markdown preview. It renders the document in a separate split; Obsidian manages notes and links. This does not reproduce every Obsidian-specific extension.

The configuration targets your planned Neovim upgrade (at least 0.12.4 for current VimTeX). There is no special VimTeX version restriction. The installed and locked revision is still v2.17 from the initial validation; after upgrading Neovim, run `:Lazy update vimtex` to update it.

The local `bin/rnvim` and `bin/glow` binaries are ignored by Git. Neovim adds this config's `bin` directory to its tool search path. On another machine, install those tools for that machine's architecture. Glow can be built with:

```sh
GOBIN="$HOME/.config/nvim/bin" go install github.com/charmbracelet/glow/v2@v2.1.1
```

The selected remote client is [remote-ssh.nvim / rnvim](https://github.com/GNITOAHC/remote-ssh.nvim). Download a release or build it with `cargo build -p rnvim --release`. The locally built source revision is recorded in `SETUP_CHOICES.md`.

## Remote editing

Use the separate launcher:

```sh
~/.config/nvim/bin/nvim-remote desktop
~/.config/nvim/bin/nvim-remote user@another-host
NVIM_REMOTE_HOST=desktop ~/.config/nvim/bin/nvim-remote
~/.config/nvim/bin/nvim-remote session list
```

An explicit host wins over the configured default. With no host, rnvim can prompt interactively. SSH aliases belong in your SSH configuration. No tmux is involved.

Disable this launcher at any time by setting `remote.enabled = false` in shared or local settings. For one invocation:

```sh
NVIM_REMOTE_DISABLED=1 ~/.config/nvim/bin/nvim-remote desktop
```

The switch blocks new connections through this launcher; it does not terminate an active session or disable direct use of a separately invoked `rnvim` binary. Local `nvim` always runs locally, and starting it makes no remote connection.

The desktop needs Neovim, this shared config, plugins, language servers, and development tools. Keep machine-specific paths in `local.lua` on each machine. The launcher forces `--no-sync-config`: rnvim's built-in sync uses `rsync --delete` and would also copy machine-specific files. Manage the shared config separately on both machines.

rnvim runs the editor, plugins, and servers remotely and attaches a local Neovim UI. Its saved sessions remember workspace locations; network-disconnect recovery and graphics behavior have not been tested here. A desktop address was not supplied, so no real connection was attempted. A remote PDF viewer normally opens on the desktop, not the laptop; PDF viewing on the laptop needs a separate file-transfer/viewing workflow.

## Editing behavior

There is no format-on-save, formatter integration, automatic import cleanup, or Obsidian frontmatter rewriting. Formatting and on-type formatting capabilities are disabled on attached LSP clients. Completion, rename, and code actions can still change text when you explicitly invoke/accept them. Indentation while typing is separate from formatting an existing file.

Notes use ordinary Markdown checkboxes for now; a separate task manager remains undecided. `todo-comments.nvim` searches TODO/FIXME comments in source code. Goplexity is installed but remains unloaded until `:Goplexity` or `Space tc`; hints are off initially and toggled on demand. Its estimates are heuristic.

## Keymaps

| Keys | Action |
| --- | --- |
| `Space w`, `Space q` | Save, quit window |
| `Ctrl h/j/k/l` | Move between windows |
| `Space hh`, `Space ll` | Previous/next buffer |
| `Space bd` | Close buffer |
| `Space tf`, `Space tl` | Find files, search project |
| `Space ts`, `Space tw` | Search current buffer with preview, search word/selection |
| `Space tb`, `Space tr`, `Space tp` | Buffers, recent files, projects |
| `Space ntt`, `Space ntf` | Explorer, reveal current file |
| `gd`, `Space gd` | Definition; one result jumps directly, several open a picker |
| `Ctrl o`, `Ctrl i`, `Ctrl t` | Back/forward in jump list, back through definition tag stack |
| `Space gt`, `gr`, `gI` | Type definition, references, implementations |
| `K`, `Space cs` | Documentation, signature |
| `Space cr`, `Space ca` | Explicit rename/code action |
| `Space ce`, `Space ct` | Wayfinder exploration, trail |
| `[d`, `]d`, `Space df` | Previous/next diagnostic, details |
| `Space dl`, `Space Q`, `Space dt` | Buffer/project diagnostic lists, toggle inline diagnostic lines |
| `Space gg`, `Space gl` | Git status, Git history graph |
| `[h`, `]h`, `Space gp`, `Space gs`, `Space gb` | Git hunks, preview, stage, blame |
| `Ctrl a`, `Ctrl x` | Increment/decrement numbers, toggle words/operators; signed numbers stay native |
| `Space tc` | Toggle Go complexity hints |
| `Space nv` | Vault file picker |
| `Space nn`, `Space nd`, `Space nb`, `Space nl` | New/daily note, backlinks, follow link (vault required) |
| `Space nc` | Toggle a Markdown checkbox, including outside a vault |
| `Space mp` | Toggle live Markdown preview split |
| `Space tt`, `[t`, `]t` | Code TODO picker, previous/next TODO |
| `Space db` | Database UI |
| `Space lc`, `Space lv`, `Space le`, `Space ls` | LaTeX compile toggle, PDF view, errors, stop |
| `Space st`, terminal `Esc Esc` | Terminal split, leave terminal input mode |
| `Space z`, `Space us`, `Space ut` | Zen mode, smooth-scroll toggle, theme picker |
| `Space uc`, `Space ul` | Shared settings, machine settings |

Search previews replace the proposed Numb plugin. Surround uses its standard mappings (`ys`, `ds`, `cs`). There is no Harpoon, Which-key, bufferline, or second explorer/picker.

## Terminal font

Iosevka is a terminal setting. After installing it, use `font-family = "Iosevka"` in Ghostty. `terminal/ghostty-font.conf` contains that setting for inclusion in your terminal configuration.

## Validation

The rebuild was checked with actual startup, all three theme families, selected extra-plugin loading, Go LSP definition requests and the mapped Snacks jump, unchanged Go/C/Markdown saves, C server attachment, Obsidian setup, Markdown checkbox toggling without a vault, a rendered Beside split, a single initialized JDT LS client, and LaTeX/TikZ compilation through VimTeX. Remote launcher arguments and disabling were tested with a fake client, without SSH. Machine settings and environment overrides were also checked. The test terminal reached its first screen in approximately 20 ms on this desktop with warm caches; that is not a laptop or cold-start measurement.
