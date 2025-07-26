# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Structure

This is a Neovim configuration forked from https://github.com/nvim-lua/kickstart.nvim and structured to minimize merge conflicts when updating from upstream. All custom modifications are isolated in the `lua/custom/` directory, allowing the main `init.lua` and kickstart files to be updated with minimal conflicts.

The configuration is organized in a modular structure:

- **`init.lua`**: Main configuration file that loads all settings, keymaps, and plugins
- **`lua/custom/`**: Custom configuration modules
  - **`options.lua`**: Custom vim options (indentation, Nerd Font settings)
  - **`keymaps.lua`**: Custom key mappings
  - **`plugins/`**: Plugin configurations
    - **`init.lua`**: Plugin imports and basic plugin setup
    - **`lsp/`**: LSP-specific configurations
      - **`lsp.lua`**: LSP server configurations (Python, Nix, Rust, Go, C/C++)
      - **`clangd_helper.lua`**: Advanced clangd setup with compile_commands.json detection and file watching

## LSP Configuration

The LSP setup includes:
- **clangd**: C/C++ with automatic compile_commands.json detection and file watching
- **pyright**: Python language server with basic type checking
- **nixd**: Nix language server  
- **ruff**: Python linter
- **texlab**: LaTeX support
- **cmake**: CMake language server

The clangd configuration in `lua/custom/plugins/lsp/clangd_helper.lua` automatically:
- Searches for compile_commands.json files using `fd`
- Watches for changes and restarts clangd when compile_commands.json is updated
- Provides a `:ReloadClangd` command for manual restart

## Key Features

- Uses **lazy.nvim** for plugin management
- **Blink.cmp** for autocompletion with LSP integration
- **Telescope** for fuzzy finding
- **Treesitter** for syntax highlighting
- **Which-key** for keymap help
- **Mini.nvim** modules for text objects, surround, and statusline
- **TokyoNight** colorscheme

## Common Commands

- `:Lazy` - Manage plugins (install, update, etc.)
- `:checkhealth` - Check Neovim configuration health
- `:ReloadClangd` - Manually restart clangd LSP server
- `<space>sh` - Search help documentation
- `<space>sf` - Find files
- `<space>sg` - Live grep search
- `<space>f` - Format current buffer

## Development Workflow

1. Configuration changes are made in `lua/custom/` files
2. Plugin configurations go in `lua/custom/plugins/`
3. LSP servers are expected to be installed system-wide (via Nix/Home Manager based on comments)
4. The configuration uses lazy loading for most plugins to optimize startup time