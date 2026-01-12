# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Overview

This is a Neovim configuration based on kickstart.nvim - a minimal, single-file starter configuration designed to be fully understood and customized. The configuration uses the Lazy.nvim plugin manager and focuses on LSP-based development with modern tooling.

## Key Commands

### Plugin Management
- View plugins: `:Lazy`
- Update plugins: `:Lazy update`
- Check health: `:checkhealth`

### LSP and Development
- Install/manage language servers: `:Mason`
- Format buffer: `<leader>f` (uses conform.nvim)
- View diagnostics: `:Telescope diagnostics` or `<leader>sd`
- Lint: Configured via nvim-lint (runs automatically on BufEnter, BufWritePost, InsertLeave)

### Testing and Linting
- Format Lua: Uses `stylua` (configured in `.stylua.toml`)
  - Column width: 160
  - Single quotes preferred
  - No call parentheses
  - 2 space indent

### Telescope (Fuzzy Finder)
- Search files: `<leader>sf`
- Search help: `<leader>sh`
- Search keymaps: `<leader>sk`
- Live grep: `<leader>sg`
- Search word: `<leader>sw`
- Search Neovim files: `<leader>sn`
- Find buffers: `<leader><leader>`

## Architecture

### Configuration Structure
- **init.lua**: Single-file configuration containing all core settings, keymaps, and plugin setup
- **lua/kickstart/**: Optional kickstart plugins (debug, lint, neo-tree, autopairs, indent_line, gitsigns)
  - These are NOT loaded by default - must be explicitly required in init.lua
- **lua/custom/plugins/**: Directory for user-added custom plugins
  - Plugins placed here are automatically loaded if `{ import = 'custom.plugins' }` is uncommented in init.lua

### Plugin Management
Uses Lazy.nvim as the plugin manager. Lazy automatically clones itself on first run if not present. Plugin specifications are defined in the `require('lazy').setup({})` call in init.lua.

### LSP Configuration
- **mason.nvim**: Automatic installation of LSP servers and tools
- **mason-lspconfig.nvim**: Bridges Mason and lspconfig
- **mason-tool-installer.nvim**: Ensures required tools are installed
- **nvim-lspconfig**: Core LSP configuration
- **blink.cmp**: Autocompletion with LSP integration
- **LuaSnip**: Snippet engine

LSP servers are defined in the `servers` table in init.lua. Currently only `lua_ls` is configured. Add servers by editing this table.

### Formatting and Linting
- **conform.nvim**: Format on save (disabled for C/C++ by default)
- **nvim-lint**: Linting framework (configure linters in lua/kickstart/plugins/lint.lua)

### Key Integrations
- **Telescope**: Fuzzy finder for files, LSP symbols, diagnostics, etc.
- **Treesitter**: Syntax highlighting and code understanding
- **gitsigns**: Git integration in gutter
- **which-key**: Displays pending keybinds
- **mini.nvim**: Multiple small utilities (statusline, surround, text objects)

### Leader Key
Space is configured as the leader key (`<leader>`). All leader-based keymaps follow mnemonic patterns:
- `<leader>s*`: Search commands
- `<leader>t*`: Toggle commands  
- `<leader>h*`: Git hunk operations

### Completion
Uses blink.cmp with default preset:
- `<c-y>` to accept completion
- `<c-space>` to open menu/docs
- `<c-n>/<c-p>` or `<up>/<down>` to navigate
- `<tab>/<s-tab>` for snippet navigation

## Development Guidelines

### Adding New Language Support
1. Add LSP server to `servers` table in init.lua (line ~673)
2. Add server name to `ensure_installed` if auto-install is desired (line ~716)
3. Configure formatter in `formatters_by_ft` table (line ~769)
4. Add linter configuration in lua/kickstart/plugins/lint.lua if needed

### Adding Plugins
Two approaches:
1. **Quick**: Add to the plugin list in `require('lazy').setup({})` in init.lua
2. **Organized**: Create a new file in `lua/custom/plugins/` and uncomment the import line in init.lua (~987)

### Optional Features
Kickstart includes optional plugins that must be explicitly required:
- Debug Adapter Protocol (DAP): `require 'kickstart.plugins.debug'`
- Linting: `require 'kickstart.plugins.lint'`
- Neo-tree file explorer: `require 'kickstart.plugins.neo-tree'`
- Auto-pairs: `require 'kickstart.plugins.autopairs'`
- Indent line: `require 'kickstart.plugins.indent_line'`
- Gitsigns keymaps: `require 'kickstart.plugins.gitsigns'`

### Configuration Philosophy
This is NOT a distribution - it's a starting point. The entire configuration is in init.lua by design so you can read and understand every line. As you learn, you may want to split it into modules using the `lua/custom/` directory.

### Nerd Font
Set `vim.g.have_nerd_font = true` in init.lua (line 94) if you have a Nerd Font installed for proper icon display.

## Important Notes

- The configuration targets Neovim stable and nightly versions only
- lazy-lock.json is gitignored in this repo but recommended to track in forks
- Leader key must be set before plugins load (currently done on line 90-91)
- All keymaps use `vim.keymap.set()` - see `:help vim.keymap.set()`
- LSP keymaps are only set when LSP attaches to a buffer
- Diagnostic configuration is at line ~631 with severity sorting and custom signs
