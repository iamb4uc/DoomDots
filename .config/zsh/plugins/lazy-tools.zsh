_doomdots_load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
    unfunction _doomdots_load_nvm 2>/dev/null
}

_doomdots_nvm_command() {
    local cmd="$1"

    shift
    unfunction nvm node npm npx corepack 2>/dev/null
    _doomdots_load_nvm
    rehash
    "$cmd" "$@"
}

nvm() { _doomdots_nvm_command nvm "$@" }
node() { _doomdots_nvm_command node "$@" }
npm() { _doomdots_nvm_command npm "$@" }
npx() { _doomdots_nvm_command npx "$@" }
corepack() { _doomdots_nvm_command corepack "$@" }

bun() {
    [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
    unfunction bun 2>/dev/null
    rehash
    command bun "$@"
}
