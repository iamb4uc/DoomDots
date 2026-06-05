lfcd() {
    local tmp dir

    tmp="$(mktemp)" || return
    lfub -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$PWD" ] && cd "$dir"
    fi
}
