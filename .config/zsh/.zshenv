cargo_env="${CARGO_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/cargo}/env"
[ -r "$cargo_env" ] && . "$cargo_env"
unset cargo_env
