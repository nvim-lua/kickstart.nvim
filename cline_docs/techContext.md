# Technical Context: Neovim Configuration

## Technologies Used

### Core Environment
- Neovim v0.11.0-dev-1731+gf8cbdbb4a8
- LuaJIT 2.1.1736781742
- Operating System: Linux 5.15
- Shell: /bin/zsh

### Key Dependencies
1. **Plugin Manager**
   - lazy.nvim for plugin management
   - Automatic plugin installation and loading

2. **Language Support**
   - nvim-lspconfig for LSP configuration
   - Treesitter for syntax highlighting
   - Mason for LSP server management

3. **User Interface**
   - Telescope for fuzzy finding
   - Which-key for keymap discovery
   - Tokyo Night color scheme
   - Mini.nvim for various UI components

## Development Setup
1. **Required Components**
   - Neovim 0.8+ (currently running 0.11.0-dev)
   - Git for plugin management
   - (Optional) Nerd Font for icons
   - Proper runtime files installation

2. **Configuration Location**
   - Main config: /home/barbosa/.config/nvim/init.lua
   - Memory Bank: /home/barbosa/.config/nvim/cline_docs/

## Technical Constraints
1. **Runtime Requirements**
   - Proper VIMRUNTIME environment variable setting
   - Access to runtime files (currently having issues)
   - vim.diagnostic module accessibility

2. **Plugin Dependencies**
   - Some plugins require specific Neovim versions
   - LSP servers need external installations
   - Some features depend on Nerd Font availability

## Dependencies
1. **Core Plugins**
   - lazy.nvim (plugin manager)
   - nvim-lspconfig (LSP support)
   - nvim-treesitter (syntax)
   - telescope.nvim (fuzzy finder)
   - mason.nvim (LSP server manager)

2. **LSP Servers**
   - Various language servers (go, python, lua, etc.)
   - External formatters and linters
   - Diagnostic tools

3. **System Requirements**
   - Git for plugin management
   - Make for some plugin builds
   - Proper runtime file installation