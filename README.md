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
- VimTeX compilation requires a TeX distribution and `latexmk`. TikZ requires the corresponding TeX packages. A separate PDF viewer is optional for compilation; Zathura is the proposed viewer for full-document navigation and source/PDF synchronization. Its integration stays disabled while Zathura is missing, avoiding compiler warnings. Snacks Image can show PDF previews inside Neovim regardless.
- Snacks Image uses ImageMagick and a supported terminal, plus parsers and TeX tools for math. Ghostty supports the required graphics protocol. Actual display must be checked in Ghostty; a headless test cannot verify it.
- Beside uses Glow for live Markdown preview. It renders the document in a separate split; Obsidian manages notes and links. This does not reproduce every Obsidian-specific extension.

Neovim is now 0.12.6. VimTeX has been updated and its revision recorded in `lazy-lock.json`; there is no special VimTeX version restriction.

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

Obsidian Tasks manages Markdown tasks and dashboards across a vault. It detects vaults using their `.obsidian/` directory, including vaults opened directly without setting `notes.vault`. Obsidian note commands still use the configured vault. The task plugin loads only for Markdown or an explicit task command; its default mappings are disabled to preserve our search mappings. Blink offers task-field completion in Markdown, and natural-language date conversion is disabled. `todo-comments.nvim` separately searches TODO/FIXME comments in source code. Goplexity is installed but remains unloaded until `:Goplexity` or `Space tc`; hints are off initially and toggled on demand. Its estimates are heuristic.

For a task dashboard, create a Markdown file inside your vault with this block:

````markdown
```tasks
not done
sort by due
```
````

Matching tasks appear under the block. Dashboard edits update the original task files; generated rows are excluded when saving the dashboard. Outside a vault, `Space nc` still toggles ordinary Markdown checkboxes.

## Keymaps

| Keys | Action |
| --- | --- |
| `Space w`, `Space q` | Save, quit window |
| `Ctrl h/j/k/l` | Move between windows |
| `Shift H`, `Shift L` (also `Space hh`, `Space ll`) | Previous/next buffer; replaces native screen-top/bottom motions |
| `Space Space` (also `Space tb`) | Open-file picker |
| `Space 1` … `Space 9` | Jump to a numbered file in the top bar |
| `Space bd` | Close buffer |
| `Space tf`, `Space tl` | Find files, search project |
| `Space ts`, `Space tw` | Search current buffer with preview, search word/selection |
| `Space tb`, `Space tr`, `Space tp` | Buffers, recent files, projects |
| `Space ntt`, `Space ntf` | Toggle explorer, focus explorer (opens it if closed) |
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
| `Space nD`, `Space nr` | Render task dashboard, refresh vault tasks |
| `Space ne`, `Space np`, `Space ng`, `Space na` | Task due date, priority, source, new task |
| `Space mp` | Toggle live Markdown preview split |
| `Space tt`, `[t`, `]t` | Code TODO picker, previous/next TODO |
| `Space db` | Database UI |
| `Space lc`, `Space lv`, `Space le`, `Space ls` | LaTeX compile toggle, PDF view, errors, stop |
| `Space lp` | Preview the compiled PDF inside Neovim through Snacks Image |
| `Space st`, terminal `Esc Esc` | Terminal split, leave terminal input mode |
| `Space z`, `Space ut` | Zen mode, theme picker |
| `Space uc`, `Space ul` | Shared settings, machine settings |

Zen uses a dark translucent backdrop with 15% visibility behind the centered editor. Terminal Neovim cannot blur its underlying text. Outside the active scope, syntax colors retain 82% of their original contrast against the background; scope transitions remain animated. This is implemented in `lua/config/zen.lua` and restored when Zen closes.

Smooth scrolling is enabled by default, without a toggle shortcut. Keyboard scrolling uses Snacks with a 280 ms animation cap. Vertical mouse-wheel events use `lua/config/scroll.lua` with 45 ms per line and a 220 ms cap; terminal buffers and picker lists keep their native mouse behavior. Zen initializes its own scroll state when opened.

Search previews replace the proposed Numb plugin. Surround uses its standard mappings (`ys`, `ds`, `cs`). There is no Harpoon, Which-key, bufferline, or second explorer/picker.

The status bar follows the editor theme with darker backgrounds, spans all windows, and uses powerline arrows with icons supplied by the existing mini.icons plugin. It shows mode, Git branch and change counts, relative file path, current-file diagnostics, a language icon, line-ending icon, LSP status, date/time, and line/column. Vertical separators distinguish the language, line-ending, and LSP items. Diagnostics update in insert mode and disappear when there are no counts. A top bar lists open files on the left. Window headers remain disabled.

## Coding activity

Discord Rich Presence uses `vyfor/cord.nvim`, loaded after startup. It shows the current filename and project, Atom dark icons (language large, Neovim small), and a repository button when a remote URL is available. After 10 minutes it shows `Idling` without a project line. It reconnects if Discord opens later. Run `:Cord status` to inspect the connection. Discord desktop must be running with activity sharing enabled; remote Neovim requires separate Discord IPC connectivity. Elapsed time is enabled, though Cord's documentation currently lists Discord timestamp rendering as broken. Appearance settings live in `lua/plugins/tracking.lua`.

WakaTime tracks coding activity through `wakatime/vim-wakatime`. Run `:WakaTimeApiKey` to enter your key locally, and `:WakaTimeToday` to see today's tracked time. Its automatic status bar item is disabled to preserve the chosen layout. The plugin manages its WakaTime CLI automatically.

## Terminal font

Ghostty uses JetBrainsMono Nerd Font, which keeps JetBrains text and permits wider icons than the Nerd Font Mono variant. `terminal/ghostty-font.conf` contains the selected family. Snacks file pickers and the explorer use mini.icons for filetype and folder icons.

## Validation

The rebuild was checked with actual startup, all three theme families, selected extra-plugin loading, Go LSP definition requests and the mapped Snacks jump, unchanged Go/C/Markdown saves, C server attachment, Obsidian setup, Markdown checkbox toggling without a vault, a rendered Beside split, a single initialized JDT LS client, and LaTeX/TikZ compilation through VimTeX. Remote launcher arguments and disabling were tested with a fake client, without SSH. Machine settings and environment overrides were also checked. The test terminal reached its first screen in approximately 20 ms on this desktop with warm caches; that is not a laptop or cold-start measurement.
