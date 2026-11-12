# Zsh entry point: instant prompt first, then options -> platform paths -> p10k -> compinit -> aliases -> plugins.
# Sourced from ~/.zshrc (symlinked by install/stow.sh).

# P10k instant prompt должен быть самым первым
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zsh_options
source ~/.zsh_platform_path

# Локальные значения (хосты, порты). Файла нет — работают дефолты из конфига.
[[ -r $HOME/.config/setup.local.zsh ]] && source $HOME/.config/setup.local.zsh

# Powerlevel10k: тема и конфиг ДО compinit, иначе instant prompt не мгновенный.
[[ -r "$p10k_theme" ]] && source "$p10k_theme"
[[ ! -r ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Completion: compinit и zstyles
source ~/.zsh_completions_conf

# sudoedit запускает редактор от текущего пользователя
export SUDO_EDITOR=nvim

# Personal aliases
[[ ! -r ~/.zsh_aliases ]] || source ~/.zsh_aliases

# Autosuggestions
[[ -r "$zsh_autosuggestions" ]] && source "$zsh_autosuggestions"

# Zoxide: ленивая инициализация — fork происходит при первом cd/z/zi,
# а не при каждом старте шелла. zi — интерактивный режим.
# Повторный source: снять алиасы, оставленные прошлой инициализацией,
# иначе объявление функций z()/zi() упадёт.
(( $+aliases[z] )) && unalias z
(( $+aliases[zi] )) && unalias zi
_zoxide_lazy() {
	unfunction _zoxide_lazy cd z zi
	eval "$(command zoxide init zsh --cmd cd)"
	alias z=cd
	alias zi=cdi
}
cd() { _zoxide_lazy; cd "$@"; }
z()  { _zoxide_lazy; cd "$@"; }
zi() { _zoxide_lazy; cdi "$@"; }

# Клавиши, буфер обмена, мелкие утилиты и пейджер
source ~/.zsh_keybindings
source ~/.zsh_clipboard
source ~/.zsh_misc

# Syntax highlighting must be loaded before history-substring-search
[[ -r "$zsh_syntax_highlighting" ]] && source "$zsh_syntax_highlighting"

# History-substring-search: печатай кусок команды, ↑/↓ листают совпадения
if [[ -r $zsh_history_substring_search ]]; then
	source "$zsh_history_substring_search"
	bindkey "$terminfo[kcuu1]" history-substring-search-up
	bindkey "$terminfo[kcud1]" history-substring-search-down
fi


