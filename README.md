# Neovim Configuration

A clean, modular Neovim configuration based on kickstart.nvim with better organization and maintainability.

## Installation

Clone this repository to your Neovim config directory:

```bash
git clone <repository-url> ~/.config/nvim
```

## Structure

### Core Configuration (`lua/user/core/`)
- `globals.lua` - Global settings and variables (leader keys, clipboard, etc.)
- `options.lua` - Vim options and editor settings
- `keymaps.lua` - Key mappings and shortcuts  
- `autocmds.lua` - Auto commands and events

### Plugin Configuration (`lua/user/plugins/`)
- Individual plugin configurations
- Main plugins are configured in `init.lua` root file
- Additional/complex plugins have separate files

### Main Files
- `init.lua` - Main configuration entry point (streamlined from 1,036 to ~400 lines)

## Key Features

- **Modular Structure**: Core settings separated from plugins for better organization
- **Clean Plugin Management**: Uses Lazy.nvim with organized plugin definitions
- **Simplified Dashboard**: Alpha dashboard reduced from 13 headers to 3 clean options
- **Consistent Keymaps**: Removed duplicates and organized by functionality
- **LSP Ready**: Full LSP support with Mason for easy language server management
- **Development Tools**: Git integration, debugging, completion, and more

## Key Mappings Highlights

### Leader Key: `<Space>`

### Core Navigation
- `<leader>ff` - Find files
- `<leader>fw` - Find words (grep)
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help

### Git Integration
- `<leader>gg` - LazyGit
- `<leader>gdi` - Diffview
- `<leader>gs` - Git stage/unstage hunk
- `<leader>gr` - Git reset hunk

### LSP Features
- `gd` - Go to definition
- `grr` - Go to references (Telescope)
- `K` - Hover documentation (built-in)
- `<leader>lr` - Rename symbol
- `<leader>la` - Code actions

### Buffer Management  
- `<S-h>` / `<S-l>` - Navigate buffers
- `<leader>bd` - Delete buffer
- `<leader>ba` - Close all but current

## Reminders

### Git Commands
- `:G` - git status, or start for any git command  
- `:Gvdiffsplit` - show diff with previous commit
- `:Gvdiffsplit develop` - show diff with develop
- `:Gread` - replace buffer with content of the last commit
- `:Gwrite` - add current file to staged files
- `:G blame` - Git Blame

## Customization

The modular structure makes it easy to:
- Add new plugins in `lua/user/plugins/`
- Modify core settings in `lua/user/core/`
- Extend keymaps without conflicts
- Maintain clean separation of concerns

