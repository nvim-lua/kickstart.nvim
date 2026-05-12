# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal Neovim config forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Loaded by Neovim from `~/.config/nvim`. There is no build/test step — changes take effect by restarting `nvim` (or `:source %` / `:Lazy reload <plugin>` for some edits).

## Architecture

- `init.lua` — entrypoint. Sets options, global keymaps, autocmds, bootstraps `lazy.nvim`, then loads every file under `lua/custom/plugins/` via `{ import = 'custom.plugins' }`. The kickstart single-file model has been broken out: only base options/keymaps live here; plugin specs live in their own files.
- `lua/custom/plugins/*.lua` — one file per plugin (or tightly related group). Each returns a lazy.nvim spec table (or list of specs). Adding a new plugin = create a new file here; it is picked up automatically. No central manifest to update.
- `lua/custom/zed-keymaps.lua` — mirrors Zed bindings (alt-j/k line move, F2 rename, `<leader>.` code action, `gb` blame, `<leader>x` close buffer, task spawners). Required directly from `init.lua` before lazy setup. Task spawner prefers a floating zellij pane (`$ZELLIJ` set) and falls back to an `nvim` split terminal.
- `lua/custom/health.lua` — backs `:checkhealth kickstart`.
- `lazy-lock.json` — committed; pin plugin versions. Update via `:Lazy update` then commit.
- `lua/kickstart/` does **not** exist in this fork (upstream kickstart had it). Don't add files there; everything custom lives under `lua/custom/`.

### Key conventions baked into the config

- **Leader = Space** (both `mapleader` and `maplocalleader`).
- **Window navigation** (`<C-h/j/k/l>`) is owned by `smart-splits.nvim` (`lua/custom/plugins/tmux.lua`) with `multiplexer_integration = 'zellij'` — at a split edge it forwards focus to the zellij pane. Don't re-bind these in `init.lua`.
- **LSP** is wired in `lua/custom/plugins/lsp.lua`. Servers configured: `clangd`, `gopls`, `pyright` (organize-imports disabled, lint suppressed — `ruff` handles both), `ruff` (hover disabled — `pyright` handles), `lua_ls`. Mason auto-installs them plus `stylua`, `jdtls`, `google-java-format`. Buffer-local LSP keymaps (`gd`, `gr`, `gI`, `<leader>rn`, `<leader>ca`, …) are set in the `LspAttach` autocmd — add new LSP keybindings there, not globally. Inlay hints are forced on for Go buffers.
- **Go imports** are organized on `BufWritePre` for `*.go` via a `source.organizeImports` code action (`lsp.lua`).
- **Formatting** is `conform.nvim` (`conform.lua`); `format_on_save` runs with `timeout_ms = 500` and LSP fallback (disabled for `c`/`cpp`). Per-ft formatters: `stylua` (lua), `ruff_organize_imports`+`ruff_format` (python), `google-java-format` (java), `terraform_fmt`, prettier (js/xml).
- **Per-filetype `colorcolumn`** is set by a `FileType` autocmd in `init.lua` (python 80, lua 100, go 120, rust 100, java 120). Other filetypes have no ruler.
- **Buffer switching**: `<A-1>`..`<A-9>` jump to `vim.t.bufs[i]` (populated by `mini.bufremove`/`mini.tabline` from `mini.lua`).
- **`;` is remapped to `:`** in normal mode. `<Esc>` clears search highlight.

## Formatting / lint for files in this repo

Lua files are formatted with **stylua** using `.stylua.toml` (2-space indent, single quotes preferred, 160-col width, no call parens). Run via `<leader>f` or `:Format`, or from a shell: `stylua .`. There is no test suite.

## Adding / modifying plugins

- New plugin → new file in `lua/custom/plugins/`, return a lazy spec. No need to edit `init.lua`.
- After edits: `:Lazy sync` (install/update/clean) or restart Neovim. Commit `lazy-lock.json` along with spec changes so the lock stays reproducible.
- Use `:checkhealth` and `:Mason` to verify tool installation.

## Repo-specific style notes

- `.stylua.toml` enforces single quotes and no call parens — keep `require 'foo'` style (not `require('foo')`) in plain calls; conform/lazy spec tables of course still use parens where required.
- Existing files have heavy kickstart-original tutorial comments. When editing those files, leave the surrounding teaching comments intact unless the user asks for cleanup; for new files, follow the global comment policy (terse, only when WHY is non-obvious).
