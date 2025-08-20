# CLAUDE.md

This file provides guidance to Claude Code when working with Neovim configuration.

## Project Leadership
You are the lead Claude for the **nvim** project. You have authority to self-assign and work on issues in this repository.

## Project Overview
A modular Neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), structured to minimize merge conflicts when updating from upstream. All custom modifications are isolated in the `lua/custom/` directory, allowing the main `init.lua` to stay in sync with kickstart while maintaining our customizations.

**Key Design Principle**: Never modify kickstart files directly - all customizations go in `lua/custom/` to ensure clean merges from upstream.

## Architecture

- **`init.lua`**: Main configuration file that loads all settings, keymaps, and plugins
- **`lua/custom/`**: Custom configuration modules
  - **`options.lua`**: Custom vim options (indentation, Nerd Font settings)
  - **`keymaps.lua`**: Custom key mappings
  - **`plugins/`**: Plugin configurations
    - **`init.lua`**: Plugin imports and basic plugin setup
    - **`lsp/`**: LSP-specific configurations
      - **`lsp.lua`**: LSP server configurations (Python, Nix, Rust, Go, C/C++)
      - **`clangd_helper.lua`**: Advanced clangd setup with compile_commands.json detection and file watching

### Key Components
- **`init.lua`**: Main configuration file that loads all settings, keymaps, and plugins
- **`lua/custom/`**: Custom configuration modules
  - **`options.lua`**: Custom vim options (indentation, Nerd Font settings)
  - **`keymaps.lua`**: Custom key mappings
  - **`plugins/`**: Plugin configurations
    - **`init.lua`**: Plugin imports and basic plugin setup
    - **`lsp/`**: LSP-specific configurations
      - **`lsp.lua`**: LSP server configurations (Python, Nix, Rust, Go, C/C++)
      - **`clangd_helper.lua`**: Advanced clangd setup with compile_commands.json detection

### LSP Servers Configured:
- **clangd**: C/C++ with automatic compile_commands.json detection and file watching
- **pyright**: Python language server with basic type checking
- **nixd**: Nix language server  
- **ruff**: Python linter
- **texlab**: LaTeX support
- **cmake**: CMake language server

## Development Commands

### Plugin Management
- `:Lazy` - Open plugin manager UI
- `:Lazy reload` - Reload plugin configurations
- `:checkhealth` - Verify all dependencies and configuration

### Search & Navigation
- `<space>sf` - Find files (Telescope)
- `<space>sg` - Live grep search (Telescope)
- `<space>sh` - Search help documentation
- `<space>sk` - Search keymaps
- `<space>/` - Fuzzy search in current buffer

### Git Operations (via vim-fugitive)
- `<leader>gs` - Git status
- `<leader>gd` - Git diff
- `<leader>gc` - Git commit
- `<leader>gb` - Git blame
- `<leader>gl` - Git log
- `<leader>gp` - Git push
- `<leader>gf` - Git fetch

### LSP Operations
- `<space>f` - Format current buffer
- `<leader>lr` - Reload all LSP servers
- `:ReloadClangd` - Manually restart clangd
- `grn` - Rename symbol
- `gra` - Code action
- `grr` - Find references
- `grd` - Go to definition

## Project-Specific Conventions
- Configuration changes are made in `lua/custom/` files
- Plugin configurations go in `lua/custom/plugins/`
- LSP servers are expected to be installed system-wide (via Nix/Home Manager)
- The configuration uses lazy loading for most plugins to optimize startup time

## External Dependencies

### System Requirements
- **git**, **make**, **unzip**, **gcc** - Basic build tools
- **ripgrep** - Fast text search (required for Telescope grep)
- **fd** - Fast file finder (required for Telescope file search)
- **Clipboard tool** - xclip/xsel on Linux, pbcopy on macOS
- **Nerd Font** - Optional but recommended for icons (currently enabled)

### Neovim Plugins
- **lazy.nvim** - Plugin management
- **Blink.cmp** - Autocompletion with LSP integration
- **Telescope** - Fuzzy finding
- **Treesitter** - Syntax highlighting
- **Which-key** - Keymap help
- **Mini.nvim** - Text objects, surround, and statusline
- **TokyoNight** - Colorscheme
- **vim-fugitive** - Git integration (`:Git` commands)
- **gitsigns.nvim** - Git gutter and hunk operations
- **nvim-tmux-navigator** - Seamless tmux/nvim navigation
- **GitHub Copilot** - AI code suggestions (being replaced with zbirenbaum/copilot.lua)

### LSP Servers (via Nix/Home Manager)
- **clangd** - C/C++
- **pyright** - Python type checking
- **ruff** - Python linting
- **nixd** - Nix language
- **texlab** - LaTeX
- **cmake-language-server** - CMake

## Common Tasks
- **Add new plugin**: Create file in `lua/custom/plugins/`, add import to `lua/custom/plugins/init.lua`
- **Update LSP config**: Edit `lua/custom/plugins/lsp/lsp.lua`
- **Change keybindings**: Edit `lua/custom/keymaps.lua`
- **Update from upstream kickstart**: 
  ```bash
  git fetch kickstart
  git merge kickstart/master
  # Conflicts should only be in init.lua, not in lua/custom/
  ```
- **Disable a plugin temporarily**: Rename to `.disabled` (e.g., `avante.lua.disabled`)
- **Test plugin changes**: `:Lazy reload` or restart Neovim
- **Check health**: `:checkhealth` to verify all dependencies

## References
- Team standards: `../CLAUDE.md`
- Git workflow: `../git-workflow.yaml`
- Development practices: `../development-practices.yaml`