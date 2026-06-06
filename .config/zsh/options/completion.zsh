_doomdots_completion_styles() {
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
    zstyle ':completion:*' rehash true
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS:-}"
    zstyle ':completion:*' completer _complete _ignored _approximate
    zstyle ':completion:*' menu select
    zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
    zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
    zstyle ':completion:*' accept-exact '*(N)'
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zshcomp"
}

_doomdots_load_completion() {
    local completion

    autoload -Uz compinit
    ZSH_COMPDUMP="${ZSH_COMPDUMP:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump}"
    mkdir -p "${ZSH_COMPDUMP:h}"

    if [[ ! -f "$ZSH_COMPDUMP" || "$ZSH_COMPDUMP" -ot "${ZDOTDIR:-$HOME/.config/zsh}/.zshrc" ]]; then
        compinit -d "$ZSH_COMPDUMP"
    else
        compinit -C -d "$ZSH_COMPDUMP"
    fi

    _doomdots_completion_styles

    for completion in "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/completions/*.zsh(N); do
        source "$completion"
    done

    [ -s "${BUN_INSTALL:-$HOME/.bun}/_bun" ] && source "${BUN_INSTALL:-$HOME/.bun}/_bun"

    unfunction _doomdots_completion_styles _doomdots_load_completion 2>/dev/null
}

if [[ -o interactive ]]; then
    _doomdots_lazy_complete() {
        _doomdots_load_completion
        bindkey '^I' complete-word
        zle complete-word
        unfunction _doomdots_lazy_complete 2>/dev/null
    }

    zle -N _doomdots_lazy_complete
    bindkey '^I' _doomdots_lazy_complete
fi
