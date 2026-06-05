path_prepend() {
    [ -d "$1" ] || return
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1${PATH:+:$PATH}" ;;
    esac
}

path_prepend "$HOME/.local/bin"
path_prepend "$CARGO_HOME/bin"
path_prepend "$GOPATH/bin"
path_prepend "$BUN_INSTALL/bin"
path_prepend "$HOME/.opencode/bin"
path_prepend /opt
export PATH

unfunction path_prepend 2>/dev/null || unset -f path_prepend 2>/dev/null
