# macos-keyboard-setup

A keyboard-driven macOS setup: Caps Lock becomes Hyper, AeroSpace tiles the
windows, Ghostty is the terminal, and zsh starts in well under 100 ms.

Exported from a working daily-driver configuration, with hosts, private app
bundle ids and personal data removed. Nothing here is a framework — it is one
person's config, kept small enough to read.

## What's inside

```
zsh/                 .zshrc, .zsh_aliases, .p10k.zsh, ... — file names are the
                     real ones in $HOME, so stow can just link them
ghostty/.config/     terminal config + documented keybinds
wm/.config/          AeroSpace (dwm-style master/stack) + borders + open-browser.sh
keys/.config/        karabiner.json: Caps Lock -> Hyper, Option+hjkl -> arrows
tools/.config/       yazi, btop, fastfetch, neovim
Brewfile             everything installable, one file
install.sh           interactive setup + stow deploy (the one command)
docs/                KEYMAP.md, WHY-FAST.md
```

Every top-level directory is a [GNU Stow](https://www.gnu.org/software/stow/)
package that mirrors `$HOME`. That is the whole design: no rename mapping, no
generator, `~/.zsh_aliases` in the repo is `~/.zsh_aliases` on the machine.

## Keymap

Full tables in [docs/KEYMAP.md](docs/KEYMAP.md). The short version:

| Keys | Action |
|---|---|
| `Caps Lock` | Hyper = `Cmd+Ctrl+Opt` |
| `Hyper+h/j/k/l` | focus window |
| `Hyper+1..9` | workspace |
| `Hyper+Shift+1..9` | move window to workspace |
| `Hyper+Enter` | promote window to master |
| `Hyper+W` | open your browser (bundle id set at install time) |
| `Hyper+E` | new Finder window |
| `Hyper+;` | AeroSpace service mode |
| `Cmd+t` / `Cmd+Shift+t` | Ghostty split right / down |
| `Ctrl+O` | copy the command line to the clipboard |
| `Esc Esc` | toggle the `sudo` prefix |

## Install

Requires macOS on Apple Silicon (the `zsh/.zsh_platform_path` file has a Linux
branch too, but see *Not included*).

```sh
git clone <this repo> ~/Projects/macos-keyboard-setup
cd ~/Projects/macos-keyboard-setup
./install.sh
```

One command. It asks a handful of questions, then symlinks everything into
`$HOME` with `stow --no-folding`. Options:

```sh
./install.sh --dry-run    # print what would happen, change nothing
./install.sh --no-prompt  # no questions, keep current values
```

The questions are all optional — press Enter to keep the shown default, or `-`
to clear the value:

| Question | Where it lands | If skipped |
|---|---|---|
| SSH host | `SSH_HOST` in `~/.config/setup.local.zsh` | remote aliases are not created |
| LAN host | `HOME_LAN_HOST` | the tunnel alias is not created |
| Ollama ports | `OLLAMA_*_PORT` | the documented defaults are used |
| Browser bundle id | `~/.config/aerospace/browser.conf` | `Hyper+W` opens Safari |

Nothing machine-specific is ever written into the repo. Files that would
conflict are moved to `~/.dotfiles-removed-<date>/` — nothing is deleted. Stow
itself is idempotent, so re-running `install.sh` after a `git pull` is safe.

Prefer plain stow? The packages work on their own:

```sh
stow --no-folding -t ~ zsh ghostty wm keys tools   # deploy
stow -D -t ~ zsh ghostty wm keys tools             # remove the links
```

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
  left out of the published tree for now — the structure (`.zsh_platform_path`
  with an `elif linux*` arm) allows adding it later without rearranging
  anything.
* **Private app bundle ids.** `wm/.config/aerospace/aerospace.toml` has a commented
  placeholder where personal bundle ids go. The published rules only use
  publicly known applications.
* **Hosts, ports, machine-specific values** — see `setup.local.example.zsh`.
* **Secrets, cookies, history, session dumps** — `.gitignore` covers these, and
  nothing in this repo has ever contained them.

## License

Config files: do whatever you want with them (MIT-style, no warranty).
Vendored snippets are credited in the file comments where they came from
(oh-my-zsh, powerlevel10k, pure).
