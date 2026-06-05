[[ -o interactive ]] || return 0

bindkey -v
bindkey -s '^o' 'lfcd\n'
bindkey -s '^f' "fzf | xargs 'nvim'\n"
bindkey -s '^n' 'mkdir -p '
bindkey -s '^c' 'cp -r '
