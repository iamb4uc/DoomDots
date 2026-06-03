autoload -U colors && colors

mkdir -p "$(dirname "$HOME/.cache/zsh/histfile")" && touch "$HOME/.cache/zsh/histfile"
HISTFILE=$HOME/.cache/zsh/histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v # Vim Keybindings -e for soymacs

autoload -Uz compinit

ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${ZSH_COMPDUMP:h}"

if [[ ! -f "$ZSH_COMPDUMP" || "$ZSH_COMPDUMP" -ot ~/.config/zsh/.zshrc ]]; then
    compinit -d "$ZSH_COMPDUMP"
else
    compinit -C -d "$ZSH_COMPDUMP"
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion
zstyle ':completion:*' rehash true                        # automatically find new executables in path
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.cache/zsh/.zshcomp

# Settings
setopt autocd            # Automatically cd into typed directory.
unsetopt correct         # Auto correct mistakes
unsetopt correctall      # Auto correct mistakes
setopt extendedglob      # Extended globbing. Allows using regular expressions with *
setopt nocaseglob        # Case insensitive globbing
setopt rcexpandparam     # Array expension with parameters
setopt nocheckjobs       # Don't warn about running processes when exiting
setopt numericglobsort   # Sort filenames numerically when it makes sense
setopt nobeep            # No beep
setopt appendhistory     # Immediately append history instead of overwriting
setopt histignorealldups # If a new command is a duplicate, remove the older one
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

#################
## Keybindings ##
#################
# Use lf to switch directories and bind it to ctrl-o
lfcd() {
    tmp="$(mktemp)"
    lfub -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'lfcd\n'
bindkey -s '^f' "fzf | xargs 'nvim'\n"
bindkey -s '^n' 'mkdir -p '
bindkey -s '^c' 'cp -r '

#############
## Aliases ##
#############
# Quick one liners for big-ass commands.
# File navigations
alias l=eza
alias ls=eza
alias la="eza -a"
alias lt="eza --tree"
alias ll="eza -l"
alias lla="eza -la"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Applications
alias v=$EDITOR
alias vi=$EDITOR
alias vim=$EDITOR
alias e=$EDITOR
alias lf=lfub
alias du=dust
alias nf="neofetch"
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias cat=bat
alias sudo=doas
alias up="uptime -p"
alias econ="nvim ~/.config/."
alias untar="tar -xvzf"
alias yt="yt-dlp --add-metadata -i"
alias yta="yt --audio-format flac"
alias peaclock="peaclock --config-dir ~/.config/peaclock"
alias wal="lf $WALLPAPERS"
alias spotdl="spotdl --output-format flac"
alias rawtojpg="find . -type f \( -iname '*.raw' -o -iname '*.nef' \) -exec sh -c 'darktable-cli {} ${0%.*}.jpg' {} \; -delete" # Converts RAW/NEF file(s) to JPG and removes the original NEF file(s) as per https://askubuntu.com/a/1337782
alias snc="rsync -avP --partial"
alias btc="bluetoothctl"
alias screc="ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -c:v libx264 -i :0.0" # You have to provide the file name along with this alias
alias pyenv="source .env/bin/activate"
alias vpn="doas openvpn"
alias THM="doas openvpn ~/.local/share/openvpn/thm.ovpn"
alias TODO="$EDITOR ~/Documents/TODO.md"
alias ble=bluetuith

# Git
alias gini="git init"
alias gstsh="git stash"
alias gdiff="git diff"
alias grm="git rm -rf"
alias gpull="git pull"
alias gad="git add"
alias gcom="git commit -m"
alias gcl="git clone --recurse-submodules"
alias gpush="git push"
alias gstat="git status"
alias glogo="git log --oneline"
alias gao="git remote add origin"
alias gcheck="git checkout"
alias gb="git branch"

# Tmux
alias t="tmux"
alias ta="tmux a -t"
alias tls="tmux ls"
alias tn="tmux new -t"
alias tks="tmux kill-server"
alias ts="tmux source $HOME/.config/tmux/tmux.conf"

# Docker
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dr="docker run"
alias dei="docker exec -it"
alias dcd="docker compose down"
alias dcu="docker compose up"
alias dcud="docker compose up -d"
alias dcudr="docker compose up -d --remove-orphans"

# Kubernetes
alias k="kubectl"
alias kg="kubectl get"
alias kgp="kubectl get pods"
alias kgpa="kubectl get pods --all-namespaces"
alias kgn="kubectl get nodes"
alias kgnam="kubectl get namespace"

# Compile(usefull with suckless MAKEFILES)
alias mc="doas make clean"
alias mci="doas make install"
alias mk="make"

# Package managers

# Pacman
alias pacin="doas pacman -S --color=always"
alias paccln="doas pacman -Sc --color=always"
alias pacsync="doas pacman -Sy --color=always"
alias pacsrch="doas pacman -Ss --color=always"
alias pacup="doas pacman -Syu --color=always"
alias pacrem="doas pacman -Rsn --color=always"

# AUR(yay)
alias yain="yay -S"
alias yacln="yay -Sc"
alias yastat="yay -Ps"
alias yaser="yay -Sc"

# XBPS
alias xq="xbps-query"
alias xql="xbps-query -l"
alias xi="doas xbps-install -S"
alias xr="doas xbps-remove"
alias xrc="doas xbps-remove -RcOo"
alias xrr="doas xbps-remove -ROo"
alias xu="doas xbps-install -Su"

# APT/APT-GET (idk much about apt package manager) (make pull request if you know about these commands.)
# TODO make more aliases for apt package manager
alias aptup="doas apt-get update"
alias aptug="doas apt-get upgrade"
alias aptin="doas apt-get install"
alias aptrm="doas apt-get remove"
alias aptautorm="doas apt-get autoremove"
alias dpkin="doas dpkg -i"

[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

for completion in "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/completions/*.zsh(N); do
    source "$completion"
done

[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshenv" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshenv"

eval "$(starship init zsh)"

# opencode
[ -d "$HOME/.opencode/bin" ] && export PATH="$HOME/.opencode/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:/opt/:$PATH"

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
