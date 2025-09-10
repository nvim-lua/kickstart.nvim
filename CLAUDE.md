# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on kickstart.nvim, a minimal starting point for Neovim configuration. The codebase is primarily single-file (init.lua) with modular plugin extensions.

## Commands

### Formatting and Linting
- **Format Lua code**: Use stylua via Mason tool installer (automatically configured)
- **Lint files**: Configured through nvim-lint plugin with markdownlint for markdown files
- **Check formatting**: GitHub Actions workflow runs stylua formatting checks

### Development Workflow
- **Start Neovim**: `nvim`
- **Plugin management**: `:Lazy` (view plugin status, updates, etc.)
- **Health check**: `:checkhealth` (verify external dependencies)
- **Mason management**: `:Mason` (manage LSP servers, formatters, linters)

### Key External Dependencies
- `git`, `make`, `unzip`, C Compiler (`gcc`)
- `ripgrep` (for Telescope search functionality)
- Clipboard tool (xclip/xsel/win32yank)
- Optional: Nerd Font (set `vim.g.have_nerd_font = true` in init.lua)

## Architecture

### File Structure
```
init.lua              # Main configuration file (single-file approach)
lua/
├── kickstart/        # Kickstart.nvim optional plugins
│   ├── health.lua    # Health check functionality
│   └── plugins/      # Modular plugin configurations
│       ├── autopairs.lua
│       ├── debug.lua
│       ├── gitsigns.lua
│       ├── indent_line.lua
│       ├── lint.lua
│       └── neo-tree.lua
└── custom/           # User custom plugins and configurations
    └── plugins/
        ├── init.lua  # Custom plugin loader (sets relativenumber)
        ├── dap.lua   # Debug adapter protocol
        ├── hardtime.lua
        └── codium.lua # Codeium AI completion
```

### Plugin Management
- **Plugin manager**: lazy.nvim
- **LSP management**: Mason + mason-lspconfig + mason-tool-installer
- **Automatic installation**: Tools specified in `ensure_installed` table are auto-installed via Mason

### Core Plugin Categories
1. **LSP & Completion**: nvim-lspconfig, nvim-cmp, mason ecosystem
2. **Fuzzy Finding**: Telescope with fzf-native extension
3. **Syntax**: nvim-treesitter with auto-update
4. **Formatting**: conform.nvim with stylua for Lua
5. **Git**: gitsigns for git integration
6. **UI**: which-key, neo-tree (file explorer)
7. **Debugging**: nvim-dap with UI extensions

### Configuration Philosophy
- Single init.lua file keeps configuration simple and readable
- Modular plugins in separate files for organization
- Lazy loading for performance
- Format-on-save enabled with LSP fallback
- Automatic tool installation via Mason

### Custom Extensions
- Relative line numbers enabled by default
- Codeium AI completion integration
- Additional debugging capabilities with nvim-dap
- Hard time plugin for Vim training

## Development Notes

- The configuration follows kickstart.nvim principles: readable, documented, and minimal
- LSP servers and tools are automatically installed via Mason
- Format-on-save is configured with LSP fallback for unsupported file types
- Plugin lazy-loading is used extensively for performance
- Custom plugins should be added to `lua/custom/plugins/` directory