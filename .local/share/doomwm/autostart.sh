#!/bin/sh

run_once() {
    name="$1"
    shift

    if ! pgrep -x "$name" >/dev/null; then
        "$@" &
    fi
}

setup_audio() {
    pulseaudio --check >/dev/null 2>&1 || pulseaudio --start
}

setup_display() {
    if xrandr | grep -q '^HDMI-A-0 connected'; then
        xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 75 --output eDP --off
        return
    fi

    if xrandr | grep -q '^eDP connected'; then
        xrandr --output eDP --primary --mode 1920x1080 --rate 60
        return
    fi

    primary="$(xrandr | awk '/ connected/{print $1; exit}')"
    [ -n "$primary" ] && xrandr --output "$primary" --primary --auto
}

setup_input() {
    xset r rate 250 60
    setxkbmap -option caps:escape
}

start_desktop() {
    setbg

    run_once doomstatus doomstatus
    run_once picom picom
    if command -v redshift >/dev/null 2>&1; then
        run_once redshift redshift
    fi
    run_once syncthing syncthing
    run_once mpd mpd
}

setup_audio
setup_display
setup_input
start_desktop
