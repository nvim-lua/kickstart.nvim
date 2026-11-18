# Copilot Instructions

Personal Neovim config forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) (`~/.config/nvim`-style layout, Lua, `lazy.nvim`). There is no build or test suite.

## Commands

- Format check (the only CI check, and it only runs on the upstream `nvim-lua/kickstart.nvim` repo): `stylua --check .`; fix with `stylua .`
- Style comes from `.stylua.toml`: 2-space indent, 160 cols, single quotes preferred, no call parentheses (`require 'foo'`, `require('foo').setup {}` when chained).
- Sanity check config loads: `nvim --headless "+Lazy! sync" +qa` (updates `lazy-lock.json`; commit it when plugins change).

## Architecture

- `init.lua`: only requires `config.options`, `config.keymaps`, `config.autocmds`, `config.lazy`, then sets the colorscheme.
- `lua/config/lazy.lua`: bootstraps `lazy.nvim` and calls `require('lazy').setup` with the spec list (inline: vim-sleuth, Comment.nvim; explicit `kickstart.plugins.*` requires; `{ import = 'custom.plugins' }`).
- `lua/kickstart/plugins/*.lua`: upstream optional plugins (debug, indent_line, autopairs, neo-tree, lint, gitsigns), enabled explicitly via `require 'kickstart.plugins.<name>'` in `init.lua` (e.g. `lint` is commented out).
- `lua/custom/plugins/*.lua`: this fork's own plugins, **auto-loaded** through `{ import = 'custom.plugins' }` in `init.lua`. Each file returns a lazy.nvim spec table; adding a file is enough to enable it (no registration needed).
- Core pieces (blink.cmp, `lspconfig.lua`, conform, treesitter, telescope, which-key, mini, gitsigns) live in `lua/custom/plugins/`. Completion is blink.cmp only. LSP uses the Neovim 0.11+ API (`vim.lsp.config` / mason-lspconfig `automatic_enable`), with server options nested under `settings`. Avoid declaring the same plugin in two files (lazy merges the specs).
- `lua/kickstart/plugins/gitsigns.lua` and `lint.lua` are unused upstream leftovers; the active gitsigns spec is `lua/custom/plugins/gitsigns.lua`.
- `lua/kickstart/health.lua`: `:checkhealth kickstart`.
- `HELPER.md`: personal Vim keybinding cheat sheet; `README.md` is upstream's.

## Conventions

- Leader is `<space>`; `vim.g.have_nerd_font = true`.
- Plugin files follow the kickstart pattern: `return { { 'author/plugin', event/keys/cmd lazy-loading, opts = {} } }`.
- Keep `lazy-lock.json` in sync with plugin additions/updates.
