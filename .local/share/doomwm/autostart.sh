#!/bin/sh
#
pulseaudio -D &
# xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 75 --output eDP --mode 1920x1080 --rate 60 --below HDMI-A-0 &
xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 75 --output eDP --off &
# xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 75 &
xset r rate 250 60 &
# xmodmap ~/.Xmodmap &
setxkbmap -option caps:escape &
slstatus &
setbg /hOme/iamb5uc/Pictures/wallpapers &
setbg &
picom &
syncthing &
mpd &
# redshift &
# mpv /home/iamb4uc/Git/dots/music/intro1.mp3
