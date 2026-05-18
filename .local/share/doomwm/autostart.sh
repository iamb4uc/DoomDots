#!/bin/sh

pgrep -x pulseaudio >/dev/null || pulseaudio -D

if xrandr | grep -q '^HDMI-A-0 connected'; then
    xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 75 --output eDP --off
else
    xrandr --output eDP --primary --mode 1920x1080 --rate 60
fi

xset r rate 250 60
setxkbmap -option caps:escape

setbg "$HOME/Pictures/wallpapers/gruvbox/"

pgrep -x doomstatus >/dev/null || doomstatus &
pgrep -x picom >/dev/null || picom &
pgrep -x syncthing >/dev/null || syncthing &
pgrep -x mpd >/dev/null || mpd &
