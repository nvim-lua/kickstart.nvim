# Repository Guidelines

## Project Structure & Module Organization
- Root entrypoint: `init.lua` (Kickstart-based primary config).
- Custom Lua modules live under `lua/custom/`.
- Plugin specs are split into `lua/custom/plugins/*.lua` (one concern per file, e.g. `gitsigns.lua`, `lint.lua`, `persistence.lua`).
- Utility modules (non-plugin config) live in `lua/custom/*.lua` (for example `wrapping.lua`, `health.lua`).
- Reference docs live in `README.md` and `doc/kickstart.txt`.
- Plugin versions are pinned in `lazy-lock.json`.

## Build, Test, and Development Commands
- `nvim`  
  Starts Neovim and triggers lazy.nvim plugin loading/install.
- `nvim --headless "+qa"`  
  Fast startup sanity check (useful in CI-style validation).
- `nvim --headless "+checkhealth" "+qa"`  
  Runs health checks for Neovim, plugins, and external tools.
- `nvim --headless "+Lazy! sync" "+qa"`  
  Syncs plugin set to current specs.
- `luac -p init.lua lua/custom/**/*.lua`  
  Lua syntax validation for config files.

## Coding Style & Naming Conventions
- Language: Lua (Neovim API style).
- Formatting: `stylua` using `.stylua.toml` settings (2-space indentation, no tabs).
- Prefer small, focused plugin spec files named by feature (`neo-tree.lua`, `markdown.lua`).
- Use descriptive keymap `desc` fields and group prefixes via which-key.
- Keep comments concise and practical; avoid repeating obvious code behavior.

## Testing Guidelines
- No formal unit-test framework is configured in this repo.
- Required checks before PR:
  - Lua parse check (`luac -p ...`)
  - Headless startup (`nvim --headless "+qa"`)
  - Health check (`:checkhealth`) for affected tooling (LSP, formatters, linters).
- For plugin/config changes, include manual verification steps in PR notes (keymaps, commands, expected behavior).

## Commit & Pull Request Guidelines
- Follow existing history style: Conventional Commit-like prefixes such as:
  - `feat(scope): ...`
  - `fix(scope): ...`
  - `chore: ...`
- Keep commits scoped to one logical change (plugin, keymap group, diagnostics, etc.).
- PRs should include:
  - Summary of behavior changes
  - Files touched (e.g. `init.lua`, `lua/custom/plugins/...`)
  - Validation performed (commands run)
  - Screenshots/GIFs only when UI behavior is materially changed.
