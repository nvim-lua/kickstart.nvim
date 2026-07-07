# Neovim Development Environment

A single-file Neovim configuration forked from Kickstart.nvim, tuned for infrastructure and backend development.

## Philosophy

- **Built for DevOps:** Deep integrations for Go, Terraform/HCL, Bicep, PowerShell, Ansible, Jinja, and Bash.
- **vim.pack native:** Uses Neovim 0.12+'s built-in `vim.pack` plugin manager — no external plugin manager needed.
- **Terminal-native:** Keyboard-driven. No GUI fluff.
- **Modular:** Each plugin lives in its own file under `lua/kickstart/plugins/`. Enable or disable by commenting a single `require` in Section 10 of `init.lua`.

## Prerequisites

Arch Linux:
```bash
sudo pacman -S --needed neovim gcc make git ripgrep fd tree-sitter-cli unzip xclip
```

Optional but recommended:
```bash
sudo pacman -S --needed shellcheck golangci-lint  # for linting
```

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
rm -rf ~/.local/share/nvim

# Clone and bootstrap
git clone https://github.com/<your-username>/nvim.git ~/.config/nvim
nvim  # Plugins auto-install on first run
```

## Core Stack

| Category | Tooling |
|---|---|
| **LSP** | gopls, terraformls, ansiblels, jinja_lsp, powershell_es, pyright, bicep-lsp, lua_ls |
| **Autocomplete** | blink.cmp + LuaSnip |
| **Fuzzy Finder** | Telescope.nvim (ripgrep + fd + fzf-native) |
| **Parsing** | Treesitter (auto-installs parsers on demand) |
| **Formatting** | conform.nvim — autoformat on save for go, hcl, ps1, lua; external hclfmt for HCL |
| **Linting** | nvim-lint — shellcheck (bash/sh/zsh), golangci-lint (Go), markdownlint (markdown) |
| **Git** | gitsigns.nvim — hunk staging, blame, diff, text objects |
| **File Tree** | neo-tree.nvim — toggle with `<leader>ff` |
| **Debug** | nvim-dap + dap-ui + dap-go (commented out by default) |

## Custom Keymaps

| Key | Action |
|---|---|
| `<C-s>` | Save file (insert + normal mode) |
| `<PageUp>` / `<PageDown>` | Scroll up/down |
| `<C-h/j/k/l>` | Navigate splits |
| `<leader>ff` | Toggle neo-tree file explorer |
| `<leader>fb` | Toggle neo-tree buffer explorer |
| `<leader>sf` | Telescope find files |
| `<leader>sg` | Telescope live grep |
| `<leader>f` | Format buffer |
| `<leader>hs` | Stage git hunk |
| `<leader>hr` | Reset git hunk |
| `<leader>tb` | Toggle git blame |

## Management

- **Check plugin status:** `:lua vim.pack.update(nil, { offline = true })`
- **Update plugins:** `:lua vim.pack.update()` (`:write` to apply, `:quit` to cancel)
- **Health check:** `:checkhealth kickstart`
- **Add a plugin:** Create `lua/kickstart/plugins/<name>.lua`, add `require 'kickstart.plugins.<name>'` in init.lua Section 10
- **Disable a plugin:** Comment its `require` in init.lua Section 10
