# Technical Context

## Core Technologies
- Neovim (Text Editor)
- Lua (Configuration Language)
- Lazy.nvim (Plugin Manager)

## Major Dependencies
1. LSP Servers & Tools
   - lua_ls
   - gopls
   - pyright
   - terraform-ls
   - and many others managed by Mason

2. Key Plugins
   - nvim-lspconfig: LSP configuration
   - telescope.nvim: Fuzzy finder
   - nvim-treesitter: Syntax highlighting
   - nvim-cmp: Completion engine
   - conform.nvim: Code formatting
   - which-key.nvim: Keybinding help
   - mini.nvim: Collection of utilities

## Development Setup
- Uses the Kickstart.nvim framework as base
- Nerd Font required for icons
- Python 3 support configured
- Git integration via fugitive and gitsigns

## Technical Constraints
- Dependent on external LSP servers
- Requires Neovim 0.8.0 or higher
- Some features require system dependencies (make, git)
- Terminal with true color support recommended

## Configuration Structure
```
.
├── init.lua (Main configuration)
└── lua/
    ├── kickstart/
    │   └── plugins/ (Plugin-specific configs)
    └── custom/
        └── plugins/ (Custom plugin configs)