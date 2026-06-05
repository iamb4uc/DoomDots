HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/histfile"
mkdir -p "${HISTFILE:h}"
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt histignorealldups
