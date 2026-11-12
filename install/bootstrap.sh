#!/usr/bin/env bash
# bootstrap.sh — install everything this setup needs, then link the dotfiles.
#
#   ./install/bootstrap.sh            # dry run of the linking step
#   ./install/bootstrap.sh --apply    # really link
#   ./install/bootstrap.sh --yes      # do not ask before installing Homebrew
#
# Idempotent: re-running it changes nothing that is already in place.
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
APPLY=0
ASSUME_YES=0
for arg in "$@"; do
  case $arg in
    --apply) APPLY=1 ;;
    --dry-run) APPLY=0 ;;
    -y | --yes) ASSUME_YES=1 ;;
    -h | --help)
      sed -n '2,10p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "unknown option: $arg" >&2
      exit 2
      ;;
  esac
done

say() { printf '\n\033[1m==> %s\033[0m\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

# ── 1. Xcode command line tools (git, compilers, make) ──────────────
say "Xcode command line tools"
if xcode-select -p >/dev/null 2>&1; then
  echo "already installed: $(xcode-select -p)"
else
  echo "missing. Starting the installer; re-run this script when it finishes."
  xcode-select --install || true
  exit 1
fi

# ── 2. Homebrew ─────────────────────────────────────────────────────
say "Homebrew"
if have brew; then
  echo "already installed: $(command -v brew)"
elif [[ -x /opt/homebrew/bin/brew || -x /usr/local/bin/brew ]]; then
  # installed but not on PATH (e.g. non-login shell)
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
  echo "found but not on PATH, added for this run"
else
  echo "not installed. Official installer:"
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  if (( ASSUME_YES )); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    read -r -p "Run the installer now? [y/N] " reply
    [[ $reply == [yY]* ]] || exit 1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

# ── 3. Packages ─────────────────────────────────────────────────────
say "Homebrew bundle (install/Brewfile)"
brew bundle --file="$REPO_DIR/install/Brewfile"

# ── 4. Dotfiles ─────────────────────────────────────────────────────
say "Linking dotfiles"
if (( APPLY )); then
  "$REPO_DIR/install/stow.sh" --apply
else
  "$REPO_DIR/install/stow.sh"
  echo
  echo "Dry run only. Re-run with --apply (or run install/stow.sh --apply) to create the links."
fi

say "Done"
echo "Open a new terminal, or: exec zsh"
