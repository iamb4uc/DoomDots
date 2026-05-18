# Dots

Personal dotfiles for a lightweight Linux desktop built around X11, DoomWM, zsh,
Neovim, lf, mpv, qutebrowser, tmux, MPD/ncmpcpp, and a small collection of
helper scripts.

The repo is intended to be installed with symlinks, not copied file by file.

## Install

Clone the repo and run:

```sh
make install
```

`make install` does the whole setup:

- removes generated runtime files from the repo, such as logs, zsh dumps, and
  media-player watch state
- creates the basic XDG directories under `$HOME`
- symlinks `.zprofile`, `.config/*`, `.local/bin`, and `.local/share` into
  `$HOME`
- backs up existing conflicting files into
  `~/.dotfiles-backup/<timestamp>/`
- restores executable bits on scripts

To install somewhere other than `$HOME`, pass `PREFIX`:

```sh
make PREFIX=/tmp/DoomDots-test install
```

## Uninstall

Remove only symlinks that point back to this repo:

```sh
make uninstall
```

This does not restore backups automatically. Backups are kept in
`~/.dotfiles-backup/`.

## Maintenance

Useful targets:

```sh
make clean   # remove generated logs, caches, and runtime state
make lint    # syntax-check shell scripts
make status  # show git status
```

## What Is Included

Desktop/session:

- `DoomWM` autostart script in `.local/share/doomwm/autostart.sh`
- X11 startup config in `.config/x11`
- compositor config in `.config/picom.conf`
- notification config in `.config/dunst`
- redshift config in `.config/redshift`
- wallpaper helper script: `setbg`

Shell and terminal:

- zsh config in `.config/zsh`
- `.zprofile`
- tmux config in `.config/tmux`
- Alacritty and Ghostty configs

Editor and tools:

- Neovim/LazyVim config in `.config/nvim`
- lf file manager config and preview scripts in `.config/lf`
- sxiv key handler in `.config/sxiv`
- zathura, glow, and neofetch configs

Browser and media:

- qutebrowser config in `.config/qutebrowser`
- mpv config and scripts in `.config/mpv`
- MPD, ncmpcpp, and mpdnotify configs

Helper scripts live in `.local/bin`, including:

- `compiler`, `opout`, `texclear`, and `getcomproot` for document workflows
- `mounter` and `unmounter` for removable devices
- `sysact` for doommenu-powered session actions
- `pman` for rendering man pages to PDF
- `lfub` for lf image previews
- `booksplit` for splitting audio by timecodes
- `void-maintenance` for Void Linux maintenance tasks

## Dependencies

These dotfiles assume a Linux desktop with X11. Install only the tools you
actually use, but the full setup expects many of the following:

```text
DoomWM doomstatus doommenu doomlock xorg xrandr xset setxkbmap xwallpaper picom
zsh starship tmux neovim lf ueberzug jq bat fzf ripgrep
alacritty ghostty qutebrowser mpv mpd ncmpcpp dunst redshift
zathura glow neofetch sxiv imagemagick ffmpeg mediainfo
```

Some scripts are distro-specific or workflow-specific:

- `void-maintenance` is for Void Linux and uses `xbps-*`, `vkpurge`, and
  `journalctl`.
- `mounter` and `unmounter` expect tools such as `lsblk`, `simple-mtpfs`,
  `cryptsetup`, `doommenu`, and `notify-send`.
- `compiler` expects language/document toolchains depending on the file type
  being compiled.

## Notes

The installer backs up conflicts before symlinking, but these are still personal
dotfiles. Read the configs and scripts before running them on a machine you care
about, especially scripts that call `sudo`, `doas`, mount devices, or clean
system state.

Runtime files are intentionally ignored by git. This includes qutebrowser local
state, mpv watch history, zsh completion dumps, logs, pid files, and similar
machine-local files.
