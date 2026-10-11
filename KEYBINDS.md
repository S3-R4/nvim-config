# Neovim keybind reference

Your custom bindings, common plugin controls, and useful native shortcuts.

**How to read this:** `Space tf` means press **Space**, then **t**, then **f**. `Ctrl+H` means hold Ctrl and press H. Uppercase letters such as `D` mean Shift+D. Unless stated otherwise, use **normal mode** (press Esc first).

## Everyday essentials

| Keys | Action |
| --- | --- |
| `Space Space` | List and choose an open file |
| `Space 1` … `Space 9` | Switch to the numbered file in the top bar |
| `Shift+H` / `Shift+L` | Previous / next open file |
| `Space tf` | Fuzzy-find a file |
| `Space tl` | Search text across the project |
| `Space w` | Save the current file |
| `Space bd` | Close the current buffer |
| `Space q` | Quit the current window |
| `Space ntf` | Focus the explorer; open it if closed |
| `gd` | Go to definition |
| `Space z` | Toggle Zen mode |

`Shift+H/L` replace Neovim's native top/bottom-of-screen motions. Unsaved files are not silently discarded.

## Files, buffers and search

| Keys | Action |
| --- | --- |
| `Space Space` or `Space tb` | Open-file picker |
| `Space 1` … `Space 9` | Jump directly to an open file by its top-bar index |
| `Shift+H` or `Space hh` | Previous buffer |
| `Shift+L` or `Space ll` | Next buffer |
| `Space bd` | Close buffer |
| `Space tf` | Fuzzy-search filenames |
| `Space tr` | Recent files |
| `Space tp` | Project picker |
| `Space tl` | Search project contents |
| `Space ts` | Search lines in the current file with preview |
| `Space tw` | Search word under cursor; also works on a visual selection |
| `Space ntt` | Toggle explorer |
| `Space ntf` | Focus explorer |
| `Esc` | Clear search highlights |

Filename matching in `Space tf` is fuzzy: letters can have gaps between them. Project text search uses text/regex matching. Explorer search currently has fuzzy matching disabled.

## Explorer controls

These keys apply **inside the explorer list**, not in the code editor.

Dotfiles (including `.gitignore`) and Git-ignored files are visible by default in the explorer and file picker. Use the hidden/ignored toggles below to hide them temporarily.

| Keys | Action |
| --- | --- |
| `/` or `i` | Focus the search input |
| `j` / `k` | Move down / up |
| `Enter` or `l` | Open file or toggle folder |
| `h` | Close folder |
| `Backspace` | Go up one directory |
| `.` | Set the current directory as the explorer root |
| `Shift+P` | Toggle file preview |
| `Shift+H` | Toggle hidden files |
| `Shift+I` | Toggle ignored files |
| `Shift+Z` | Close all folders |
| `a` | Add a file or directory; end directory names with `/` |
| `r` | Rename |
| `d` | Delete selected file(s) |
| `y` / `p` | Copy file paths / paste files |
| `c` / `m` | Copy / move selected files |
| `Tab` / `Shift+Tab` | Select item and move next / previous |
| `v` or `Shift+V` | Select files using visual mode |
| `u` | Refresh tree |
| `o` | Open with the system application |
| `Space /` | Search file contents in the selected directory |
| `Ctrl+T` | Open terminal in the selected directory |
| `Ctrl+C` | Change the tab's working directory |
| `[g` / `]g` | Previous / next Git change |
| `[d` / `]d` | Previous / next diagnostic |
| `[w` / `]w` | Previous / next warning |
| `[e` / `]e` | Previous / next error |
| `?` | Show explorer/picker key help |

For a single unselected file, `m` prompts to rename it and `c` prompts for a copy destination.

## Search picker controls

These apply inside file, buffer and text-search pickers. Input-mode shortcuts work while typing; list shortcuts work when focused on the result list.

| Keys | Action | Where |
| --- | --- | --- |
| `Ctrl+J` / `Ctrl+K` | Next / previous result | Input or list |
| `Ctrl+N` / `Ctrl+P` | Next / previous result | Input or list |
| `Down` / `Up` | Next / previous result | Input or list |
| `Enter` | Open selected result | Input or list |
| `Ctrl+S` / `Ctrl+V` | Open in horizontal / vertical split | Input or list |
| `Ctrl+T` | Open in a new Neovim tab | Input or list |
| `Shift+Enter` | Choose a destination window and open | Input or list |
| `Alt+P` | Toggle preview | Input or list |
| `Ctrl+B` / `Ctrl+F` | Scroll preview up / down | Input or list |
| `Ctrl+U` / `Ctrl+D` | Scroll results up / down | Input or list |
| `Tab` / `Shift+Tab` | Select item and move next / previous | Input or list |
| `Ctrl+A` | Select all results | Input or list |
| `Ctrl+Q` | Send results to quickfix | Input or list |
| `Alt+H` / `Alt+I` | Toggle hidden / ignored files | Input or list |
| `Alt+M` | Toggle maximized picker | Input or list |
| `Alt+W` | Cycle picker windows | Input or list |
| `Ctrl+G` | Toggle live search, where supported | Input |
| `Alt+R` | Toggle regex search, where supported | Input |
| `Ctrl+Up` / `Ctrl+Down` | Previous / next search history entry | Input |
| `Ctrl+W` | Delete previous word | Input, insert mode |
| `Ctrl+C` | Cancel picker | Input, insert mode |
| `Esc` | Leave insert mode; press again to cancel | Input |
| `/` | Switch between input and results | Normal mode |
| `i` | Focus input | List |
| `j` / `k`, `gg` / `G` | Navigate results, first / last result | Normal mode |
| `q` | Cancel picker | Normal mode |
| `?` | Show contextual key help | Normal mode |

The explorer overrides some shared picker keys: notably `Ctrl+T` opens a terminal, `Ctrl+C` changes directory, and `H` toggles hidden files.

## Windows, terminal and scrolling

| Keys | Action |
| --- | --- |
| `Ctrl+H` / `Ctrl+J` / `Ctrl+K` / `Ctrl+L` | Focus left / below / above / right window |
| `Space st` | Open terminal in a bottom split |
| `Esc Esc` | Leave terminal input mode |
| `Space z` | Toggle Zen mode |
| `Ctrl+D` / `Ctrl+U` | Scroll down / up half a page (native) |
| `Ctrl+F` / `Ctrl+B` | Scroll down / up a page (native) |
| Mouse wheel | Scroll with animation in regular file buffers |

Smooth scrolling stays enabled by default. There is no smooth-scroll toggle binding.

## Programming and navigation

Language-server bindings become available when an LSP attaches to the file.

| Keys | Action |
| --- | --- |
| `gd` or `Space gd` | Go to definition |
| `Space gt` | Go to type definition |
| `gr` | Find references |
| `gI` | Find implementations |
| `K` | Show documentation |
| `Space cr` | Rename symbol |
| `Space ca` | Show code actions |
| `Space cs` | Show signature help |
| `Space ce` | Explore symbol with Wayfinder |
| `Space ct` | Open Wayfinder exploration trail |
| `Space tc` | Toggle Go complexity hints; initially off |
| `Ctrl+O` / `Ctrl+I` | Back / forward through jump history (native) |

Definition search jumps directly when there is one result and opens a picker for multiple results. No formatting shortcut or automatic formatting is configured.

## Diagnostics

| Keys | Action |
| --- | --- |
| `[d` / `]d` | Previous / next diagnostic |
| `Space df` | Show diagnostic details |
| `Space dl` | Put current file diagnostics in the location list |
| `Space Q` | Put project diagnostics in quickfix |
| `Space dt` | Toggle diagnostic text below code lines |

## Git

| Keys | Action |
| --- | --- |
| `Space gg` | Open Git status (Fugitive) |
| `Space gl` | Toggle compact Git graph sidebar on the right (all branches) |
| `[h` / `]h` | Previous / next changed section |
| `Space gp` | Preview changed section |
| `Space gs` | Stage changed section |
| `Space gb` | Show blame for the current line |

The graph shows branch labels and shortened commit subjects without dates or authors. In the graph, `Enter` opens commit details and `g?` shows Flog's controls. `Space gl` closes the graph again.

## Notes and Markdown

Vault actions require `notes.vault` in your settings. Checkbox toggling also works in ordinary Markdown files.

| Keys | Action |
| --- | --- |
| `Space nv` | Open notes vault |
| `Space nn` | New note |
| `Space nd` | Today's daily note |
| `Space nb` | Show backlinks |
| `Space nl` | Follow note link |
| `Space nc` | Toggle task checkbox |
| `Space mp` | Toggle live Markdown preview split |

## Tasks and code TODOs

| Keys | Action |
| --- | --- |
| `Space nD` | Render Obsidian task dashboard |
| `Space nr` | Refresh vault tasks |
| `Space na` | Add vault task |
| `Space ne` | Set task due date |
| `Space np` | Set task priority |
| `Space ng` | Go to task source |
| `Space nc` | Toggle task checkbox |
| `Space tt` | Find code TODO comments |
| `[t` / `]t` | Previous / next code TODO |

Obsidian tasks manage Markdown checkboxes in your vault. Code TODO search finds comments such as `TODO` and `FIXME` in source files.

## LaTeX and TikZ

Use these in a TeX document. Compilation requires your TeX tools; external viewing requires the configured viewer.

| Keys | Action |
| --- | --- |
| `Space lc` | Toggle continuous compilation |
| `Space ls` | Stop compilation |
| `Space lp` | Preview compiled PDF inside Neovim |
| `Space lv` | Open external PDF viewer |
| `Space le` | Show compilation errors |

## Completion — insert mode

| Keys | Action |
| --- | --- |
| `Ctrl+Space` | Show completion; show/hide documentation when already open |
| `Ctrl+N` / `Ctrl+P` or `Down` / `Up` | Next / previous suggestion |
| `Enter` | Accept selected suggestion; otherwise normal Enter |
| `Ctrl+Y` | Select and accept a suggestion |
| `Ctrl+E` | Cancel completion |
| `Tab` / `Shift+Tab` | Next / previous snippet field |
| `Ctrl+B` / `Ctrl+F` | Scroll documentation up / down |
| `Ctrl+K` | Show/hide signature help |

Suggestions are not preselected or inserted automatically. These controls are context-specific: `Ctrl+K` focuses the upper window in normal mode but controls signature help in insert mode.

Typed brackets and quotes automatically get closing partners through nvim-autopairs. Blink separately adds brackets when accepting supported function completions. Enter keeps the completion/newline behavior described above.

## Surround and number editing

| Keys | Action | Mode |
| --- | --- | --- |
| `ys{motion}{pair}` | Surround text covered by a motion | Normal |
| `yss{pair}` | Surround current line | Normal |
| `yS{motion}{pair}` / `ySS{pair}` | Surround motion / line with delimiters on separate lines | Normal |
| `ds{pair}` | Delete surrounding delimiters | Normal |
| `cs{old}{new}` | Change surrounding delimiters | Normal |
| `cS{old}{new}` | Change delimiters, putting replacements on separate lines | Normal |
| `S{pair}` / `gS{pair}` | Surround selection inline / on separate lines | Visual |
| `Ctrl+G`, then `s{pair}` | Insert surrounding pair around cursor | Insert |
| `Ctrl+G`, then `S{pair}` | Insert pair on separate lines | Insert |
| `Ctrl+A` / `Ctrl+X` | Increase / decrease number or supported token | Normal |

Examples: `ysiw"` surrounds a word with quotes; `ds"` removes quotes; `cs"'` changes double quotes to single quotes.

## Database and settings

| Keys | Action |
| --- | --- |
| `Space db` | Toggle database interface |
| `Space ut` | Compare color themes |
| `Space uc` | Edit shared settings |
| `Space ul` | Edit machine-specific settings |

Remote editing currently has no custom editor keybind; use the configured `bin/nvim-remote` launcher.

## Dashboard

These single-letter keys apply on the home screen only.

| Key | Action |
| --- | --- |
| `f` | Find files |
| `g` | Search project contents |
| `p` | Projects |
| `r` | Recent files |
| `n` | Notes |
| `c` | Config |
| `q` | Quit |

## Useful native controls

These are built into Neovim, rather than custom config bindings.

| Keys | Action |
| --- | --- |
| `i` / `a` | Insert before / after cursor |
| `v` / `Shift+V` / `Ctrl+V` | Character / line / block selection |
| `u` / `Ctrl+R` | Undo / redo |
| `.` | Repeat last edit |
| `/text`, then Enter | Search forward |
| `n` / `N` | Next / previous search match |
| `%` | Jump to matching bracket |
| `gg` / `G` | First / last line |
| `zz` | Center cursor line on screen |
| `za` / `zo` / `zc` | Toggle / open / close fold |
| `gt` / `gT` | Next / previous Neovim tab |

This reference covers all custom mappings and common plugin controls, not every native or plugin-specific mapping. For a plugin window's full controls, use its contextual help; Snacks pickers expose this with `?` in normal mode. To inspect a binding's source, use `:verbose nmap KEY` (or `:verbose imap KEY` for insert mode).
