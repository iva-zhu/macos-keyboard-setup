#!/usr/bin/env bash
# stow.sh — symlink the files in this repo into $HOME.
#
#   ./install/stow.sh            # dry run: print what would happen
#   ./install/stow.sh --apply    # create the symlinks
#
# Rules:
#   * target already points at the repo  -> untouched
#   * target exists and is a real file   -> moved to ~/.dotfiles-removed-<date>/<path>
#   * target missing                     -> symlinked
#
# GNU Stow is not required: the layout here is intentionally explicit
# (`zsh/options` -> `~/.zsh_options`), which a plain mapping table expresses
# better than stow's package/prefix rules.
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_DIR="${HOME}"
BACKUP_DIR="$HOME_DIR/.dotfiles-removed-$(date +%Y%m%d)"
APPLY=0
for arg in "$@"; do
  case $arg in
    --apply) APPLY=1 ;;
    --dry-run) APPLY=0 ;;
    -h | --help) sed -n '2,14p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

# repo path : target path under $HOME
MAPPINGS=(
  "zsh/zshrc:.zshrc"
  "zsh/zprofile:.zprofile"
  "zsh/options:.zsh_options"
  "zsh/platform_path:.zsh_platform_path"
  "zsh/completions:.zsh_completions_conf"
  "zsh/aliases:.zsh_aliases"
  "zsh/keybindings:.zsh_keybindings"
  "zsh/clipboard:.zsh_clipboard"
  "zsh/misc:.zsh_misc"
  "zsh/p10k.zsh:.p10k.zsh"
  "terminal/ghostty/config:.config/ghostty/config"
  "terminal/ghostty/keybinds:.config/ghostty/keybinds"
  "wm/aerospace/aerospace.toml:.config/aerospace/aerospace.toml"
  "wm/borders/bordersrc:.config/borders/bordersrc"
  "keys/karabiner.json:.config/karabiner/karabiner.json"
  "tools/yazi:.config/yazi"
  "tools/btop/btop.conf:.config/btop/btop.conf"
  "tools/fastfetch/config.jsonc:.config/fastfetch/config.jsonc"
  "tools/helix/config.toml:.config/helix/config.toml"
  "tools/nvim:.config/nvim"
)

linked=0 skipped=0 backed=0

link_one() { # $1 = absolute source, $2 = absolute target
  local src=$1 dst=$2
  if [[ -L $dst && "$(readlink "$dst")" == "$src" ]]; then
    skipped=$((skipped + 1))
    return
  fi
  if (( ! APPLY )); then
    if [[ -e $dst || -L $dst ]]; then
      echo "BACKUP  $dst -> $BACKUP_DIR/${dst#"$HOME_DIR"/}"
    fi
    echo "LINK    $dst -> $src"
    linked=$((linked + 1))
    return
  fi
  mkdir -p "$(dirname "$dst")"
  if [[ -e $dst || -L $dst ]]; then
    local rel=${dst#"$HOME_DIR"/}
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    mv "$dst" "$BACKUP_DIR/$rel"
    backed=$((backed + 1))
  fi
  ln -s "$src" "$dst"
  linked=$((linked + 1))
}

for mapping in "${MAPPINGS[@]}"; do
  rel_src=${mapping%%:*}
  rel_dst=${mapping#*:}
  src_abs="$REPO_DIR/$rel_src"
  [[ -e $src_abs ]] || { echo "missing in repo: $rel_src" >&2; exit 1; }
  if [[ -d $src_abs ]]; then
    while IFS= read -r -d '' file; do
      sub=${file#"$src_abs"/}
      link_one "$file" "$HOME_DIR/$rel_dst/$sub"
    done < <(find "$src_abs" -type f -print0)
  else
    link_one "$src_abs" "$HOME_DIR/$rel_dst"
  fi
done

mode="applied"
(( APPLY )) || mode="dry run"
echo
echo "$mode: $linked link(s), $skipped already in place, $backed file(s) moved aside"
(( APPLY )) || echo "nothing was changed; re-run with --apply"
(( backed == 0 )) || echo "backups: $BACKUP_DIR"
