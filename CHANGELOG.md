# Changelog

## 2026-07-07 — Full Decoupling Refactor

### Architecture: Monolith → Modular

Extracted all plugin configurations from `init.lua` into individual files under `lua/kickstart/plugins/`. init.lua shrank from **949 → 334 lines** and now serves as a spine: options, keymaps, build hooks, and a clean `require` table in Section 10.

Each plugin is now a self-contained file — to enable or disable, comment or uncomment a single `require` line.

### New Files Created

| File | Purpose |
|---|---|
| `lua/kickstart/util.lua` | Shared `gh()` helper for GitHub URL shorthand |
| `lua/kickstart/plugins/guess-indent.lua` | Auto-detect indentation |
| `lua/kickstart/plugins/gitsigns.lua` | Git signs + hunk keymaps (consolidated) |
| `lua/kickstart/plugins/which-key.lua` | Pending keybind display |
| `lua/kickstart/plugins/tokyonight.lua` | Colorscheme (tokyonight-night) |
| `lua/kickstart/plugins/todo-comments.lua` | Highlight TODO/FIXME in comments |
| `lua/kickstart/plugins/mini.lua` | mini.ai + mini.surround + mini.statusline |
| `lua/kickstart/plugins/telescope.lua` | Fuzzy finder + LSP pickers + keymaps |
| `lua/kickstart/plugins/lsp.lua` | LSP servers + Mason + LspAttach keymaps |
| `lua/kickstart/plugins/conform.lua` | Formatting (go, hcl, ps1, lua) + hclfmt |
| `lua/kickstart/plugins/blink.lua` | blink.cmp + LuaSnip autocomplete |
| `lua/kickstart/plugins/treesitter.lua` | Syntax parsing + auto-install |

### Existing Files Modified

| File | Change |
|---|---|
| `init.lua` | Sections 4-9 extracted into plugin files; Section 10 rewritten as clean require table |
| `lua/kickstart/plugins/lint.lua` | Expanded from markdown-only to shell/bash/zsh + Go linting |
| `lua/kickstart/plugins/gitsigns.lua` | Consolidated signs config + on_attach keymaps (was duplicated) |
| `README.md` | Rewritten with full stack docs, keymap table, modular architecture guide |

### Files Removed

- `lazy-lock.json` — leftover from lazy.nvim era (migrated to vim.pack)
- `lua/kickstart/plugins/neo-tree.lua` — removed (user prefers Telescope for file navigation)
- `lua/custom/plugins/init.lua` — removed in prior cleanup
- `containerfix` branch — deprecated, deleted

### New Features

- **Linting enabled**: shellcheck for bash/sh/zsh, golangci-lint for Go
- **Gitsigns keymaps**: hunk navigation (`]c`/`[c`), staging (`<leader>hs`), blame (`<leader>tb`), word diff (`<leader>tw`)
- **System deps documented**: `Makefile` for one-command dependency installation

### How to Use

```bash
# Install system dependencies
make install

# Enable/disable plugins: edit init.lua Section 10
# Add a plugin: create lua/kickstart/plugins/<name>.lua, add require in Section 10
```
