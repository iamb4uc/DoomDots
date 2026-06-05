# zsh

Small modules. No framework.

## startup

- `.zprofile` loads login environment from `env/`.
- `.zshrc` loads interactive shell modules through `lib/loader.zsh`.
- Completion is lazy. First Tab loads `compinit` and custom completions.
- `nvm`, `node`, `npm`, `npx`, `corepack`, and `bun` are lazy stubs.

## layout

- `env/` is for exported variables, PATH, and login session setup.
- `options/` is for history, shell options, completion, and keybindings.
- `functions/` is for shell functions.
- `aliases/` is for aliases grouped by tool or job.
- `plugins/` is for optional interactive extras.

## rules

- Add a module only when it has a clear job.
- Keep `.zshrc` as a loader, not a junk drawer.
- Do not change existing aliases casually. They are workflow.
