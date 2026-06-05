source_zsh_file() {
    [ -r "$1" ] && source "$1"
}

source_zsh_modules() {
    local module_dir="$1"
    local module

    shift
    for module in "$@"; do
        source_zsh_file "${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/$module_dir/$module.zsh"
    done
}
