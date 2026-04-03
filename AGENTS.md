# AGENTS.md

Agent-facing contributor guide for this Neovim config repository.

## Repository Snapshot

- Project type: personal/forked `kickstart.nvim` configuration.
- Primary language: Lua.
- Entry point: `init.lua`.
- Additional modules: `lua/custom/**` and `lua/kickstart/**`.
- Plugin manager: `lazy.nvim`.
- Lockfile: `lazy-lock.json` (tracks plugin versions).

## Sources Used For This Guide

- `README.md`
- `.stylua.toml`
- `init.lua`
- `lua/custom/**/*.lua`
- `lua/kickstart/**/*.lua`

## Cursor/Copilot Rules

- No `.cursorrules` file found.
- No `.cursor/rules/` directory found.
- No `.github/copilot-instructions.md` found.
- Therefore: follow this `AGENTS.md` + existing repository conventions.

## Environment and Prerequisites

- Neovim target: latest stable or nightly (README states this explicitly).
- External tools commonly expected:
  - `git`, `make`, `unzip`, `rg` (checked by `lua/kickstart/health.lua`).
  - Often useful: `fd`, `tree-sitter` CLI.
  - Formatters used by config: `stylua`, `prettier`, `bean-format`.
- If tooling is missing, prefer graceful degradation over hard failure.

## Build / Lint / Test Commands

This repo is a config repo, so "build" and "test" are mostly lint/health/smoke checks.

## Quick Command Matrix

- Full format check:
  - `stylua --check .`
- Apply Lua formatting:
  - `stylua .`
- Sync/install plugins headlessly:
  - `nvim --headless "+Lazy! sync" +qa`
- Run kickstart health checks headlessly:
  - `nvim --headless "+checkhealth kickstart" +qa`
- Open once for runtime/plugin errors (manual smoke):
  - `nvim`

## Single-Test Guidance (Important)

There is no formal unit-test framework (no `busted`, `plenary` test suite, `make test`, etc.).

Use one of these "single check" equivalents when you need narrow validation:

- Single file syntax check (if Lua compiler available):
  - `luac -p path/to/file.lua`
- Single module load check in Neovim:
  - `nvim --headless "+lua require('custom.plugins.opencode')" +qa`
  - Replace module path as needed.
- Single feature health check:
  - `nvim --headless "+checkhealth kickstart" +qa`
  - Read only the section relevant to your change.

If a task asks for "run one test", use a module-load or syntax check above and report it as a targeted smoke test.

## Validation Order For Agents

When making code changes, run checks in this order unless task says otherwise:

1. `stylua --check .`
2. Targeted module/syntax check for changed file(s).
3. `nvim --headless "+checkhealth kickstart" +qa` for broader sanity.

If a command is unavailable locally, state it clearly and provide the exact command for humans/CI.
If a command is unavailable locally, state it clearly and provide the exact command for the local machine.

## Code Style: Formatting

Formatting rules are authoritative in `.stylua.toml`:

- Indentation: 2 spaces.
- Max column width: 160.
- Line endings: Unix.
- Quote style: `AutoPreferSingle` (prefer single quotes).
- Call parentheses: `None` where valid (`require 'x'` style).
- Collapse simple statements: always.

Never hand-format against Stylua output; run Stylua instead.

## Code Style: Imports and Module Structure

- Prefer local requires near first use:
  - `local builtin = require 'telescope.builtin'`
- For plugin specs, return a Lua table from module root:
  - `return { ... }`
- Keep plugin declarations declarative (`opts`) unless imperative setup is necessary (`config = function() ... end`).
- In `init.lua`, follow existing kickstart ordering and comment style.
- Avoid introducing new top-level globals.

## Code Style: Types and Annotations

This repo uses LuaLS annotations heavily. Preserve and extend when useful:

- `---@module 'lazy'`
- `---@type LazySpec`
- Plugin-specific types where available (e.g. `Gitsigns.Config`, `conform.setupOpts`).
- Use `---@diagnostic disable-next-line: ...` only when justified and narrowly scoped.

Do not remove useful annotations just to reduce lines.

## Code Style: Naming Conventions

- Modules/files:
  - lower_snake_case for filenames where practical.
  - plugin files grouped by feature in `lua/custom/plugins/`.
- Local variables/functions:
  - descriptive lower_snake_case.
  - short names only for conventional temporary values (`buf`, `opts`, `client`).
- Augroup names:
  - stable, descriptive strings (e.g. `'NeoTreeAutoRefresh'`, `'kickstart-lsp-highlight'`).
- Keymap descriptions:
  - concise, action-oriented, consistent bracket hints used by which-key.

## Code Style: Error Handling and Resilience

- Prefer non-fatal behavior for optional dependencies.
  - Example pattern already used: `pcall(require('telescope').load_extension, 'fzf')`.
- Guard external tool usage with `vim.fn.executable(...)` when needed.
- Use `vim.notify(..., vim.log.levels.WARN/ERROR)` for actionable user-facing issues.
- Keep startup robust: avoid hard errors for optional plugin features.

## Plugin and Dependency Conventions

- Add plugins through `lazy` specs, keeping structure consistent with existing blocks.
- When adding a new plugin, prefer putting it under `lua/custom/plugins/*.lua` (or other custom modules) instead of editing upstream kickstart blocks in `init.lua`, to minimize merge conflicts with upstream updates.
- Prefer minimal configuration first (`opts = {}`), then extend only if needed.
- Respect platform guards (e.g., `make` checks, Windows conditionals).
- Do not edit lockfile manually; let lazy manage `lazy-lock.json` updates.

## Custom Keymap and Layout Conventions

- Keep **custom** keymaps in `lua/custom/keymaps.lua`.
- Keep upstream kickstart keymaps in `init.lua` unless intentionally overriding behavior.
- If adding a new `<leader>` namespace in `lua/custom/keymaps.lua`, also register its group in which-key (`init.lua` `which-key` spec).
- Keep layout/window helper logic centralized in `lua/custom/layout.lua` (for example `focus_main_window()`), and reuse it from plugin modules instead of duplicating sidebar/window filtering logic.
- If a plugin needs startup window choreography, call `require('custom.layout')` helpers rather than re-implementing window focus rules.

## Editing and Change Scope

- Keep changes minimal and local to the requested task.
- Do not refactor unrelated sections opportunistically.
- Preserve existing comments unless they become inaccurate.
- Maintain ASCII unless file already relies on Unicode symbols/icons.

## Change Hygiene For Agents

- Before finalizing: run formatting + at least one targeted runtime check.
- Mention exactly what you validated and what you could not validate.
- If no formal tests exist, explicitly say "no unit test suite in this repo".
- Include file paths in reports so reviewers can jump directly.

## When Unsure

- Follow existing patterns in nearby files first.
- Prefer reversible, low-risk changes.
- Ask for clarification only when ambiguity materially changes behavior.
