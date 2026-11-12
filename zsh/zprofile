# Login-shell environment: Homebrew shellenv + ~/.local/bin for pipx-installed tools.
# Goes to ~/.zprofile.

# Homebrew: Apple Silicon and Intel prefixes
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Created by `pipx` on 2025-07-31 08:07:50
export PATH="$PATH:$HOME/.local/bin"

