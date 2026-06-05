[[ -o interactive ]] || return 0

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
