# 🚀 Modular Neovim Configuration

A clean, fast, and fully-featured Neovim configuration with perfect separation of concerns. Built on modern plugins with LSP, TreeSitter, and Copilot integration. Originally forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and transformed into a maintainable modular structure.

## ✨ Features

### 🎯 Core Features
- **Modular Architecture** - Clean separation between core settings, plugin specs, and configurations
- **LSP Support** - Full language server integration for C/C++, Python, Nix, LaTeX, and more
- **Intelligent Completion** - [Blink.cmp](https://github.com/saghen/blink.cmp) with Copilot integration
- **Fuzzy Finding** - Telescope with FZF for lightning-fast file and text search
- **Git Integration** - Fugitive + Gitsigns for complete git workflow
- **Syntax Highlighting** - TreeSitter-based highlighting with automatic parser installation
- **Debugging** - Full DAP (Debug Adapter Protocol) support

### 🔧 Language Support
- **C/C++** - clangd with automatic compile_commands.json detection
- **Python** - Pyright + Ruff for type checking and linting
- **Nix** - Full nixd integration
- **LaTeX** - TeXLab for document preparation
- **CMake** - CMake language server
- **Lua** - Optimized for Neovim config development

## 📁 Project Structure

```
nvim/
├── init.lua                    # Minimal bootstrapper
├── lua/
│   ├── core/                   # Core Neovim settings
│   │   ├── bootstrap.lua       # Lazy.nvim installation
│   │   ├── options.lua         # Editor options
│   │   ├── keymaps.lua         # Core keybindings
│   │   ├── autocmds.lua        # Auto commands
│   │   └── health.lua          # Health checks
│   └── plugins/
│       ├── spec/               # Plugin declarations
│       │   ├── lsp.lua         # Language servers
│       │   ├── blink.lua       # Completion
│       │   ├── telescope.lua   # Fuzzy finder
│       │   ├── treesitter.lua  # Syntax highlighting
│       │   ├── git.lua         # Git integration
│       │   └── ...             # Other plugins
│       └── config/             # Plugin configurations
│           ├── lsp/            # LSP setup
│           ├── blink.lua       # Completion config
│           ├── telescope.lua   # Telescope config
│           └── ...             # Other configs
```

## 🚀 Installation

### Prerequisites

#### System Requirements
- **Neovim** >= 0.10
- **Git** - Version control
- **Make** - Build tool
- **C Compiler** - For native extensions
- **ripgrep** - Fast text search
- **fd** - Fast file finder

#### Language Servers (Install via Nix/Homebrew/Package Manager)
```bash
# Example with Nix
nix-env -iA nixpkgs.clang-tools    # clangd
nix-env -iA nixpkgs.pyright        # Python LSP
nix-env -iA nixpkgs.ruff           # Python linter
nix-env -iA nixpkgs.nixd           # Nix LSP
nix-env -iA nixpkgs.texlab         # LaTeX LSP
```

### Install Configuration

#### Backup Existing Config
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

#### Clone This Repository
```bash
git clone https://github.com/yourusername/nvim.git ~/.config/nvim
```

#### Launch Neovim
```bash
nvim
```

The first launch will automatically:
1. Install lazy.nvim plugin manager
2. Download and install all plugins
3. Set up TreeSitter parsers

### Health Check

After installation, run `:checkhealth core` to verify:
- Neovim version
- Required executables
- LSP servers
- Formatters

## 🔄 Syncing with Kickstart.nvim

This configuration maintains compatibility with upstream kickstart.nvim while keeping all customizations in a modular structure. Here's how to sync with kickstart updates:

### Initial Setup (One Time)
```bash
# Add kickstart as a remote
git remote add kickstart https://github.com/nvim-lua/kickstart.nvim
git fetch kickstart
```

### Checking for Updates
```bash
# See what changed in kickstart
git fetch kickstart
git log kickstart/master --oneline

# Review specific changes
git diff HEAD kickstart/master -- init.lua
```

### Cherry-Picking Updates
```bash
# Option 1: Cherry-pick specific commits
git cherry-pick <commit-hash>

# Option 2: Manually review and integrate changes
git diff kickstart/master -- init.lua | less

# Option 3: Check for specific feature updates (e.g., telescope)
git diff kickstart/master -- init.lua | grep -A5 -B5 telescope
```

### Update Workflow
1. **Review Changes**: Check kickstart's commit history for interesting updates
2. **Test Locally**: Apply changes in a test branch first
3. **Adapt to Modular Structure**: Move any new plugins/configs to appropriate `lua/plugins/` files
4. **Document**: Update relevant documentation for new features

### Example: Adding a New Plugin from Kickstart
If kickstart adds a new plugin in their `init.lua`:
1. Create a new spec file: `lua/plugins/spec/newplugin.lua`
2. Add configuration to: `lua/plugins/config/newplugin.lua` (if needed)
3. Update: `lua/plugins/spec/init.lua` to import the new spec

## ⌨️ Key Mappings

### Leader Key
The leader key is set to `<Space>`.

### Essential Keybindings

#### File Navigation
| Key | Description |
|-----|-------------|
| `<leader>sf` | **S**earch **F**iles |
| `<leader>sg` | **S**earch by **G**rep |
| `<leader>sh` | **S**earch **H**elp |
| `<leader><leader>` | Switch buffers |
| `<leader>/` | Fuzzy search in current buffer |

#### LSP Features
| Key | Description |
|-----|-------------|
| `gd` | **G**oto **D**efinition |
| `gr` | **G**oto **R**eferences |
| `gI` | **G**oto **I**mplementation |
| `<leader>rn` | **R**e**n**ame symbol |
| `<leader>ca` | **C**ode **A**ction |
| `K` | Hover documentation |
| `<space>f` | **F**ormat buffer |

#### Git Operations
| Key | Description |
|-----|-------------|
| `<leader>gs` | Git status (Fugitive) |
| `<leader>gd` | Git diff |
| `<leader>gc` | Git commit |
| `<leader>gb` | Git blame |
| `]c` | Next git change |
| `[c` | Previous git change |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |

#### Debugging
| Key | Description |
|-----|-------------|
| `<F5>` | Start/Continue debugging |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<F7>` | Toggle debug UI |

#### Window Navigation (Tmux-aware)
| Key | Description |
|-----|-------------|
| `<C-h>` | Navigate left |
| `<C-j>` | Navigate down |
| `<C-k>` | Navigate up |
| `<C-l>` | Navigate right |

### Completion Keybindings
| Key | Description |
|-----|-------------|
| `<C-Space>` | Trigger completion |
| `<C-y>` | Accept completion |
| `<C-e>` | Cancel completion |
| `<Tab>` | Next snippet placeholder |
| `<S-Tab>` | Previous snippet placeholder |

## 🔌 Installed Plugins

### Core
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua utilities

### Editor Enhancement
- [mini.nvim](https://github.com/echasnovski/mini.nvim) - Collection of minimal plugins
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Smart commenting
- [vim-sleuth](https://github.com/tpope/vim-sleuth) - Auto-detect indentation
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto-close brackets
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides
- [vim-illuminate](https://github.com/RRethy/vim-illuminate) - Highlight word under cursor

### UI/Theme
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - Color scheme
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding hints
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight TODO comments

### Navigation
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - FZF sorter
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Seamless tmux navigation

### Git
- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Git commands
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git gutter signs

### LSP & Completion
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [blink.cmp](https://github.com/saghen/blink.cmp) - Completion engine
- [lazydev.nvim](https://github.com/folke/lazydev.nvim) - Lua development
- [fidget.nvim](https://github.com/j-hui/fidget.nvim) - LSP progress

### Development
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Syntax-aware text objects
- [copilot.lua](https://github.com/zbirenbaum/copilot.lua) - GitHub Copilot
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatting
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) - Debug Adapter Protocol
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - Debug UI

## 🛠️ Configuration

### Customization

All configuration files are designed to be easily customizable:

1. **Core Settings**: Edit files in `lua/core/`
   - `options.lua` - Vim options
   - `keymaps.lua` - Core keybindings

2. **Add Plugins**: Create new spec files in `lua/plugins/spec/`
   ```lua
   -- lua/plugins/spec/myplugin.lua
   return {
     'username/plugin-name',
     opts = {
       -- plugin options
     }
   }
   ```

3. **Complex Plugin Config**: Add config files to `lua/plugins/config/`

### LSP Server Configuration

LSP servers are configured in `lua/plugins/config/lsp/init.lua`. Add new servers to the `servers` table:

```lua
servers = {
  myserver = {
    settings = {
      -- server-specific settings
    }
  }
}
```

### Formatter Configuration

Formatters are configured in `lua/plugins/spec/formatting.lua`:

```lua
formatters_by_ft = {
  javascript = { "prettier" },
  -- add your formatters here
}
```

## 🔧 Commands

### Custom Commands
- `:ReloadLSP` - Restart all LSP servers

### Health Check
- `:checkhealth core` - Run configuration health check

### Plugin Management
- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Update all plugins
- `:Lazy profile` - Profile startup time

## 🐛 Troubleshooting

### First Steps
1. Run `:checkhealth core` to verify installation
2. Check `:messages` for error messages
3. Ensure all prerequisites are installed

### Common Issues

**Plugins not loading**
- Run `:Lazy sync` to ensure all plugins are installed
- Check for errors in `:messages`

**LSP not working**
- Verify language servers are installed (check with `:checkhealth core`)
- Run `:LspInfo` to see active servers
- Try `:ReloadLSP` to restart servers

**Telescope not finding files**
- Ensure `ripgrep` and `fd` are installed
- Check you're not in a git-ignored directory

## 📝 License

This configuration is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and is available under the MIT License.

## 🙏 Acknowledgments

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Initial configuration structure
- [Neovim](https://neovim.io/) - The best text editor
- All plugin authors for their amazing work

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report issues
- Suggest new features
- Submit pull requests

---

**Happy Coding!** 🎉