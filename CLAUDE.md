# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on kickstart.nvim, refactored into a modular structure for better organization and maintainability. The configuration separates core settings, keymaps, and plugins into logical modules.

## Architecture

### Modular Configuration Structure

The configuration is organized into three main directories:

```
~/.config/nvim/
├── init.lua                      # Bootstrap file that loads everything
├── lua/
│   ├── config/                   # Core Neovim configuration
│   │   ├── options.lua          # Vim settings (leader, numbering, clipboard, etc.)
│   │   ├── keymaps.lua          # Global key mappings
│   │   └── autocommands.lua     # Autocommands (highlight on yank, etc.)
│   ├── plugins/                  # Plugin specifications (auto-loaded by lazy.nvim)
│   │   ├── autopairs.lua        # Auto-close brackets and quotes
│   │   ├── claude-code.lua      # Claude Code integration
│   │   ├── colorscheme.lua      # Color scheme (kanso.nvim + alternatives)
│   │   ├── completion.lua       # blink.cmp & LuaSnip
│   │   ├── flash.lua            # Rapid cursor movement
│   │   ├── formatting.lua       # conform.nvim for code formatting
│   │   ├── gitsigns.lua         # Git signs and operations
│   │   ├── harpoon.lua          # File bookmarking
│   │   ├── lsp.lua              # LSP configuration & Mason
│   │   ├── lualine.lua          # Status line
│   │   ├── oil.lua              # File browser
│   │   ├── snacks.lua           # Utility plugin
│   │   ├── telescope.lua        # Fuzzy finder
│   │   ├── treesitter.lua       # Syntax highlighting & parsing
│   │   ├── vim-sleuth.lua       # Auto-detect indentation
│   │   ├── vim-tmux-navigator.lua  # Tmux/Vim navigation
│   │   ├── which-key.lua        # Keybinding hints
│   │   └── optional/            # Optional plugins (not loaded by default)
│   │       ├── README.md        # Instructions for enabling optional plugins
│   │       ├── debug.lua        # DAP debugger for Go
│   │       ├── indent-blankline.lua  # Indentation guides
│   │       └── lint.lua         # Linting with nvim-lint
│   └── custom/
│       └── plugins/
│           └── init.lua         # User-added custom plugins
```

### Plugin Management
- **Plugin Manager**: lazy.nvim (bootstrapped in init.lua)
- **Auto-Loading**: All files in `lua/plugins/*.lua` are automatically loaded
- **Custom Plugins**: Add your own in `lua/custom/plugins/init.lua` or create new files there

### Key Plugins

Each plugin is in its own file for easy management:

- **lsp.lua** - LSP configuration with Mason, servers: `pyright`, `zls`, `rust_analyzer`, `ts_ls`, `lua_ls`
- **completion.lua** - blink.cmp autocompletion with LuaSnip snippets
- **telescope.lua** - Fuzzy finder with vertical layout, fzf and ui-select extensions
- **harpoon.lua** - Quick file bookmarking and navigation
- **flash.lua** - Rapid cursor movement with `s`, `S`, `r`, `R` keys
- **oil.lua** - File browser with `-` key binding
- **vim-tmux-navigator.lua** - Seamless tmux/vim split navigation
- **formatting.lua** - conform.nvim with format-on-save (stylua, prettier)
- **gitsigns.lua** - Git signs in gutter with staging/diffing keymaps
- **which-key.lua** - Keybinding hints popup
- **lualine.lua** - Status line with base16 theme
- **treesitter.lua** - Syntax highlighting for multiple languages
- **autopairs.lua** - Auto-close brackets and quotes
- **vim-sleuth.lua** - Auto-detect indentation
- **snacks.lua** - Utility plugin collection
- **colorscheme.lua** - Multiple color schemes (kanso active)

## Common Commands

### Plugin Management
```
:Lazy                    " View plugin status
:Lazy update             " Update all plugins
:Mason                   " Manage LSP servers and tools (press g? for help)
```

### LSP & Diagnostics
```
:LspInfo                 " Show LSP client status
:ConformInfo             " Show formatter status
<leader>q                " Open diagnostic quickfix list
```

### File Navigation
```
<leader>sf               " Search files
<leader>sg               " Live grep
<leader><leader>         " Find buffers
<leader>sn               " Search Neovim config files
-                        " Open Oil file browser (parent directory)
```

### Harpoon (File Bookmarking)
```
<leader>a                " Add file to Harpoon
<leader>e                " Toggle Harpoon menu
<leader>1-4              " Jump to Harpoon mark 1-4
<leader>n/<leader>p      " Next/Previous Harpoon mark
```

### Code Operations
```
grn                      " LSP rename
gra                      " Code action
grr                      " Find references (Telescope)
grd                      " Go to definition (Telescope)
gri                      " Go to implementation (Telescope)
grt                      " Go to type definition (Telescope)
gO                       " Document symbols (Telescope)
gW                       " Workspace symbols (Telescope)
<leader>m                " Format buffer
```

### Git Operations (gitsigns)
```
]c / [c                  " Next/previous git change
<leader>hs               " Stage hunk
<leader>hr               " Reset hunk
<leader>hS               " Stage buffer
<leader>hu               " Undo stage hunk
<leader>hR               " Reset buffer
<leader>hp               " Preview hunk
<leader>hb               " Blame line
<leader>hd               " Diff against index
<leader>hD               " Diff against last commit
<leader>tb               " Toggle git blame line
<leader>tD               " Toggle git show deleted
```

## Configuration Details

### Settings (lua/config/options.lua)
- Leader key: `<space>`
- Line numbers: relative + absolute
- No line wrapping
- Clipboard: synced with OS
- Undo history: persisted
- Scrolloff: 10 lines
- Cursor: blinking block in normal mode, vertical bar in insert

### Treesitter Languages (lua/plugins/treesitter.lua)
Auto-installed parsers for: zig, python, typescript, rust, htmldjango, bash, c, html, lua, markdown, vim

### Color Scheme (lua/plugins/colorscheme.lua)
Currently using kanso.nvim. Several commented-out alternatives available (gruvbox-material, catppuccin, kanagawa, zenbones, vague).

### Custom Keymaps (lua/config/keymaps.lua)
- `<C-d>/<C-u>`: Page down/up with recentering
- `<C-h/j/k/l>`: Window navigation
- `<Esc>`: Clear search highlights

## Development Notes

### Modifying Configuration

**Core Settings**: Edit files in `lua/config/`
- `options.lua` - Vim options and settings
- `keymaps.lua` - Global key mappings
- `autocommands.lua` - Autocommands

**Plugins**: Edit corresponding files in `lua/plugins/`
- Each plugin category has its own file
- Changes take effect after `:source $MYVIMRC` or restarting Neovim
- Run `:Lazy sync` if plugins were added/removed

### Adding New Plugins

1. **Create a new file** in `lua/plugins/` (e.g., `my-plugin.lua`)
2. **Return a table** with plugin specs:
   ```lua
   return {
     {
       'author/plugin-name',
       config = function()
         -- plugin configuration
       end,
     },
   }
   ```
3. **Restart Neovim** - lazy.nvim will auto-discover and load it

### Adding New LSP Servers

1. Edit `lua/plugins/lsp.lua`
2. Add server to the `servers` table
3. Optionally add to `ensure_installed`
4. Restart Neovim - mason-tool-installer will auto-install

### Adding Formatters

1. Edit `lua/plugins/formatting.lua`
2. Add to `formatters_by_ft` table
3. Install via `:Mason` or ensure it's in PATH
4. Optionally add to `ensure_installed` in `lua/plugins/lsp.lua`

### Plugin Organization Philosophy

- **One Plugin Per File**: Each plugin has its own dedicated file in `lua/plugins/` (except colorscheme.lua which contains theme options)
- **Easy Discovery**: Plugin files are named after the plugin they configure
- **Modular**: Add/remove individual plugins by managing single files
- **Custom Additions**: Use `lua/custom/plugins/` for your personal plugins without modifying core structure

### Optional Plugins

The `lua/plugins/optional/` directory contains plugins that are not enabled by default but may be useful:

- **debug.lua** - DAP debugger primarily configured for Go (extensible to other languages)
- **indent-blankline.lua** - Adds indentation guides on blank lines
- **lint.lua** - Linting with nvim-lint (includes markdown example)

**To enable an optional plugin**, move it from `lua/plugins/optional/` to `lua/plugins/`:
```bash
mv lua/plugins/optional/debug.lua lua/plugins/debug.lua
```

Or import it directly in your `init.lua`:
```lua
require('lazy').setup({
  { import = 'plugins' },
  { import = 'plugins.optional.debug' },  -- Enable debug plugin
})
```

See `lua/plugins/optional/README.md` for more details.
