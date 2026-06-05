export XINITRC="${XINITRC:-$XDG_CONFIG_HOME/x11/xinitrc}"

if [ -n "${XDG_RUNTIME_DIR:-}" ]; then
    export XAUTHORITY="${XAUTHORITY:-$XDG_RUNTIME_DIR/Xauthority}"
    [ -e "$XAUTHORITY" ] || : >"$XAUTHORITY"
    chmod 600 "$XAUTHORITY" 2>/dev/null
fi

tty_name="$(tty 2>/dev/null)"
[ -n "$tty_name" ] && [ "$tty_name" != "not a tty" ] && export GPG_TTY="$tty_name"

if [ -z "${DOOMDOTS_PROFILE_SKIP_STARTX:-}" ] &&
    [ "$tty_name" = "/dev/tty1" ] &&
    ! pidof -s Xorg >/dev/null 2>&1; then
    exec startx "$XINITRC"
fi

unset tty_name
