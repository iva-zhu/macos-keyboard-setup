# Keymap

Everything below is the setup this repo is exported from: Caps Lock becomes
**Hyper** (`Cmd+Ctrl+Opt`), and the window manager listens on Hyper so plain
`Cmd` shortcuts keep working inside apps.

## Karabiner-Elements (system-wide)

| Keys | Action |
|---|---|
| `Caps Lock` | Hyper = `Cmd+Ctrl+Opt` (no Shift) |
| `Opt+h/j/k/l` | arrow left/down/up/right (works in any app, Shift selects) |
| `Opt+Tab` | `Cmd+Tab` (app switcher without moving the hand) |
| `F5` | `fn+F5` — plain F5 instead of the dictation key |

## AeroSpace — main mode

Layouts: workspace `i`, `iii`, `v` are `h_tiles` with a 55% master column;
`ii`, `iv` are accordions. `ix` is forced to the secondary monitor.

| Keys | Action |
|---|---|
| `Hyper+h/j/k/l` | focus left/down/up/right |
| `Hyper+Shift+h/j/k/l` | move window left/down/up/right |
| `Hyper+=` / `Hyper+-` | grow / shrink (smart resize) |
| `Hyper+r` then `h/j/k/l`, `Esc` | resize mode |
| `Hyper+Enter` | promote focused window to master (dwm zoom) |
| `Hyper+Alt+,` / `Hyper+Alt+.` | accordion / tiles layout |
| `Hyper+g` | toggle floating |
| `Hyper+q` | close window |
| `Hyper+1..9` | switch to workspace |
| `Hyper+Shift+1..9` | move window to workspace |
| `Hyper+Tab` | jump back and forth between two workspaces |
| ``Hyper+` `` | move workspace to next monitor |
| `Hyper+;` | service mode (below) |
| `Cmd+Shift+Enter` | new Ghostty window |
| `Hyper+e` | new Finder window |
| `Hyper+w` | open your browser (bundle id from `~/.config/aerospace/browser.conf`) |

### service mode (`Hyper+;`)

| Keys | Action |
|---|---|
| `g` | toggle floating, back to main |
| `r` | flatten workspace tree |
| `s` | balance sizes |
| `1..9` | send window to workspace |
| `Backspace` | close all windows but the focused one |
| `x` | toggle AeroSpace enabled |
| `Up` / `Down` | volume up / down |
| `Esc` | reload config, back to main |

## Ghostty

Custom bindings (everything else is Ghostty's stock macOS set, documented in
`ghostty/.config/ghostty/keybinds`):

| Keys | Action |
|---|---|
| `Cmd+t` | split right |
| `Cmd+Shift+t` | split down |
| `Cmd+Shift+h/j/k/l` | focus split left/down/up/right |
| `Cmd+Shift+z` | zoom split (tmux `prefix+z` equivalent) |
| `Cmd+Shift+e` | equalize splits |
| `Cmd+Shift+[` / `]` | previous / next tab |
| `Cmd+k` | clear screen |

## zsh

| Keys | Action |
|---|---|
| `Ctrl+O` | copy the current command line to the clipboard |
| `Esc Esc` | prefix the line with `sudo`, or remove it; on an empty line it pulls the previous command first |
| `End` | accept the autosuggestion |
| `Ctrl+←/→` | word back / word forward |
| `↑` / `↓` | history search by the prefix already typed |
| `Tab`, `Shift+Tab` | completion menu, previous item |

Handy commands and functions:

| Command | Action |
|---|---|
| `y` / `ya` | yazi that changes the shell directory on exit |
| `extract <archive>` | unpack anything bsdtar understands |
| `copyfile <file>` / `copypath [path]` | clipboard from the shell |
| `genpass [len] [s]` | random password |
| `ts <date>` / `unts <epoch>` | date <-> epoch |
| `ports` | listening TCP ports with the owning process |
| `rm` | goes to the Trash; `rm -rf` still deletes for real |

Double-ESC (`sudo-command-line`) is the one binding kept from a Linux habit:
it matters on the Arch box, on macOS it is mostly used for the occasional
`sudo nvim /etc/...`. It is cheap, so it stays.

## Neovim

| Keys | Action |
|---|---|
| `Ctrl+h/j/k/l` | move between windows |
| `Ctrl+←/→/↑/↓` | resize by 2 |
| `jj` (insert) | leave insert mode |
| `<leader>ts` | cycle onedark style |

## Helix

| Keys | Action |
|---|---|
| `Space+C` | `select_all` then pipe through a shell command |
