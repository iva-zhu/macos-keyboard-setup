# macos-keyboard-setup

A keyboard-driven macOS setup: Caps Lock becomes Hyper, AeroSpace tiles the
windows, Ghostty is the terminal, and zsh starts in well under 100 ms.

Exported from a working daily-driver configuration, with hosts, private app
bundle ids and personal data removed. Nothing here is a framework — it is one
person's config, kept small enough to read.

## What's inside

```
zsh/                 modular zsh config: rc, options, aliases, keybindings,
                     clipboard, completions, p10k
terminal/ghostty/    terminal config + documented keybinds
wm/aerospace/        tiling window manager config (dwm-style master/stack)
wm/borders/          focus ring for the active window
keys/karabiner.json  Caps Lock -> Hyper, Option+hjkl -> arrows, Option+Tab
tools/               yazi, btop, fastfetch, helix, neovim
install/             Brewfile, bootstrap.sh, stow.sh
docs/                KEYMAP.md, WHY-FAST.md
```

## Keymap

Full tables in [docs/KEYMAP.md](docs/KEYMAP.md). The short version:

| Keys | Action |
|---|---|
| `Caps Lock` | Hyper = `Cmd+Ctrl+Opt` |
| `Hyper+h/j/k/l` | focus window |
| `Hyper+1..9` | workspace |
| `Hyper+Shift+1..9` | move window to workspace |
| `Hyper+Enter` | promote window to master |
| `Hyper+;` | AeroSpace service mode |
| `Cmd+t` / `Cmd+Shift+t` | Ghostty split right / down |
| `Ctrl+O` | copy the command line to the clipboard |
| `Esc Esc` | toggle the `sudo` prefix |
| `ff` | pick a window with fzf |

## Install

Requires macOS on Apple Silicon (the `zsh/platform_path` file has a Linux
branch too, but see *Not included*).

```sh
git clone <this repo> ~/Projects/macos-keyboard-setup
cd ~/Projects/macos-keyboard-setup
./install/bootstrap.sh          # Xcode CLT -> Homebrew -> bundle -> dry-run links
./install/bootstrap.sh --apply  # same, but actually create the symlinks
```

`install/stow.sh` can be run on its own. It is a dry run by default; with
`--apply` it symlinks the repo files into `$HOME` and moves anything it would
overwrite to `~/.dotfiles-removed-<date>/` — no file is ever deleted.

Machine-specific values (LAN host, SSH host, local ports) are not in the repo:

```sh
cp zsh/setup.local.example.zsh ~/.config/setup.local.zsh
chmod 600 ~/.config/setup.local.zsh   # fill in your own values
```

Without that file the shell still starts cleanly; the tunnel aliases are simply
not defined.

Some files need a manual step after linking:

* Karabiner-Elements — enable the Karabiner driver, then the profile in
  `keys/karabiner.json` is picked up. Caps Lock must be remapped there before
  any Hyper binding works.
* AeroSpace — `start-at-login = true` is already set; grant Accessibility.
* Ghostty — the config uses `MesloLGS NF` (from `font-meslo-lg-nerd-font`).

## Startup budget

`zsh -i -c exit` on an M-series MacBook: **~67 ms total**, of which ~39 ms is
instrumented work (compinit 15, p10k 16, syntax-highlighting 6). The p10k
instant prompt is sourced before `compinit`, so the prompt is on screen long
before that work finishes.

Details and the profiling method: [docs/WHY-FAST.md](docs/WHY-FAST.md).

## Screenshot

_(placeholder — a screenshot of AeroSpace with two workspaces and the prompt
goes here: `docs/screenshot.png`)_

## Not included

* **Linux branches.** The zsh config (and `platform_path`, `clipboard`, some
  aliases) has an Arch Linux branch, used on a home server. It is deliberately
  left out of the published tree for now — the structure (`zsh/platform_path`
  with an `elif linux*` arm) allows adding it later without rearranging
  anything.
* **Private app bundle ids.** `wm/aerospace/aerospace.toml` has a commented
  placeholder where personal bundle ids go. The published rules only use
  publicly known applications.
* **Hosts, ports, machine-specific values** — see `setup.local.example.zsh`.
* **Secrets, cookies, history, session dumps** — `.gitignore` covers these, and
  nothing in this repo has ever contained them.

## License

Config files: do whatever you want with them (MIT-style, no warranty).
Vendored snippets are credited in the file comments where they came from
(oh-my-zsh, powerlevel10k, pure).
