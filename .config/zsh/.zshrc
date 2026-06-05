if [[ -z "${DOOMDOTS_PROFILE_LOADED:-}" && -r "$HOME/.zprofile" ]]; then
    DOOMDOTS_PROFILE_SKIP_STARTX=1 source "$HOME/.zprofile"
    unset DOOMDOTS_PROFILE_SKIP_STARTX
fi

source "${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/lib/loader.zsh"

source_zsh_modules options history shell
source_zsh_modules functions lf
source_zsh_modules options keybindings
source_zsh_modules options completion
source_zsh_modules aliases navigation applications git tmux docker kubernetes build packages
source_zsh_modules plugins lazy-tools syntax-highlighting autosuggestions prompt

unfunction source_zsh_file source_zsh_modules
