# Login profile. Environment lives under ${ZDOTDIR:-$HOME/.config/zsh}/env.

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

profile_modules=(
    defaults
    tools
    path
    session
)

for profile_module in "${profile_modules[@]}"; do
    [ -r "$ZDOTDIR/env/$profile_module.zsh" ] && . "$ZDOTDIR/env/$profile_module.zsh"
done

unset profile_module profile_modules
export DOOMDOTS_PROFILE_LOADED=1
