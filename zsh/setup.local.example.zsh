# Local values for the zsh config — copy this file and keep it out of git.
#
#   cp zsh/setup.local.example.zsh ~/.config/setup.local.zsh
#   chmod 600 ~/.config/setup.local.zsh
#   $EDITOR ~/.config/setup.local.zsh
#
# zsh/aliases reads these variables. Anything left unset simply means the
# matching alias is not created — the shell never errors out because of a
# missing file.

# LAN address of your router; router-tunnel forwards its web UI to localhost.
HOME_LAN_HOST=192.0.2.1
# SSH host used by the tunnel aliases and the `ыыр` shortcut.
SSH_HOST=you@example.com
# Port of a local Ollama instance; llm-tunnel exposes it at OLLAMA_TUNNEL_PORT
# (default 11112) on this machine.
OLLAMA_LOCAL_PORT=11434
