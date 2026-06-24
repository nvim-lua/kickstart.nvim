# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Kickstart-based Neovim config using lazy.nvim as the plugin manager. Single `init.lua` + modular custom plugins under `lua/custom/plugins/`.

## Plugin Manager

lazy.nvim — plugins defined as lazy specs (`return { "owner/repo", ... }`).

Update plugins: `:Lazy update`  
Check status: `:Lazy`  
Install/manage LSP tools: `:Mason`

## Structure

```
init.lua                        — Sections 1–9: foundation → plugins
lua/custom/plugins/init.lua     — Auto-loads all *.lua files in same dir
lua/custom/plugins/*.lua        — User-added plugins (no merge conflicts from upstream)
lua/kickstart/plugins/*.lua     — Optional kickstart examples (indent_line, lint, gitsigns)
lazy-lock.json                  — Lockfile (commit this)
```

`init.lua` is organized into `do...end` blocks by section:
1. Foundation (options, keymaps, autocmds)
2. lazy.nvim bootstrap + setup
3. UI/UX (gitsigns, which-key, mini.nvim, todo-comments)
4. Search/Navigation (Telescope)
5. LSP (mason, nvim-lspconfig, fidget)
6. Formatting (conform.nvim)
7. Autocomplete & Snippets (blink.cmp + LuaSnip)
8. Treesitter
9. Optional examples

## Custom Plugins

| File | Purpose |
|------|---------|
| `claude.lua` | claudecode.nvim — `<leader>a*` keymaps; depends on snacks.nvim |
| `lsp.lua` | dbt language server config for SQL/YAML files |
| `markdown.lua` | live-preview.nvim |
| `notebook.lua` | molten-nvim (Jupyter), image.nvim (magick_cli), wezterm.nvim |
| `oil.lua` | oil.nvim file manager via mini.icons |
| `themes.lua` | gruvbox-medium (active), tokyonight (installed) |
| `toggle-term.lua` | toggleterm.nvim terminal toggle |

## LSP

Servers are configured in `init.lua:670` via `vim.lsp.config(name, server)` + `vim.lsp.enable(name)`.  
Custom dbt server lives in `lua/custom/plugins/lsp.lua` — requires `dbt-language-server` in `$PATH`.  
Lua formatting disabled in `lua_ls`; formatting delegated to `stylua` via conform.nvim.

## Key Bindings (leader = `<space>`)

- `<leader>s*` — Telescope search
- `<leader>f` — format buffer (conform)
- `<leader>a*` — Claude Code integration
- `<leader>h*` — gitsigns hunk operations
- `<leader>t*` — toggles (inlay hints, blame, word diff)
- `gr*` — LSP actions (rename, code action, references, definitions)

## Adding Plugins

Drop a `.lua` file in `lua/custom/plugins/` — auto-required on next start. Use the lazy spec pattern:

```lua
return {
  "owner/repo",
  opts = {},
}
```

## Formatting & Linting

- **Formatter**: conform.nvim — `<leader>f` to format; auto-format on save disabled by default (opt-in per filetype in `init.lua:760`)
- **Linter**: nvim-lint — runs on `BufEnter`/`BufWritePost`/`InsertLeave`; markdownlint for markdown
- **Treesitter**: auto-installs parsers on `FileType` event
