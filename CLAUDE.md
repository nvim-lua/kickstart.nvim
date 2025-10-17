# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on kickstart.nvim - a single-file starter configuration that prioritizes being small, documented, and understandable. The configuration has been customized with additional plugins and settings.

## Architecture

### Single-File Configuration
The entire configuration is contained in `init.lua` (lines 1-1001). This is intentional - kickstart.nvim uses a single-file approach as a teaching tool and reference. While splitting into modules is possible, the current structure keeps everything in one place for clarity.

### Plugin Management
- **Plugin Manager**: lazy.nvim (installed at init.lua:122-130)
- **Plugin Definitions**: All plugins defined in the `lazy.setup()` call starting at init.lua:143
- **Custom Plugins**: Additional user plugins can be added in `lua/custom/plugins/init.lua`

### Key Plugin Categories

1. **LSP Configuration** (init.lua:435-698)
   - Mason for LSP installation (init.lua:454-456)
   - Configured servers: `pyright`, `zls`, `rust_analyzer`, `ts_ls`, `lua_ls`
   - LSP capabilities enhanced by blink.cmp (init.lua:624)
   - Autocommands for LSP attach events setup keymaps and highlighting

2. **Completion** (init.lua:746-837)
   - blink.cmp for autocompletion
   - LuaSnip for snippet expansion
   - Default keymap preset uses `<c-y>` to accept

3. **Telescope** (init.lua:255-359)
   - Fuzzy finder with vertical layout
   - Extensions: fzf, ui-select
   - Leader-based keymaps for searching files, grep, diagnostics, etc.

4. **Navigation & Movement**
   - Harpoon2 for file bookmarking (init.lua:375-432)
   - Flash.nvim for rapid cursor movement (init.lua:361-373)
   - Oil.nvim for file browsing (init.lua:964-978)
   - vim-tmux-navigator for seamless tmux/vim navigation (init.lua:154-170)

5. **Formatting** (init.lua:701-744)
   - conform.nvim handles formatting
   - Format on save enabled (except for C/C++)
   - Configured formatters: stylua (Lua), prettier (JS/TS/CSS/HTML/JSON)

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

## Configuration Details

### Settings
- Leader key: `<space>` (init.lua:2)
- Line numbers: relative + absolute (init.lua:9-10)
- No line wrapping (init.lua:19)
- Clipboard: synced with OS (init.lua:21-23)
- Undo history: persisted (init.lua:29)
- Scrolloff: 10 lines (init.lua:61)
- Cursor: blinking block in normal mode, vertical bar in insert (init.lua:68-72)

### Treesitter Languages
Auto-installed parsers for: zig, python, typescript, rust, htmldjango, bash, c, html, lua, markdown, vim (init.lua:912-929)

### Color Scheme
Currently using kanso.nvim (init.lua:848-856). Several commented-out alternatives available (gruvbox-material, catppuccin, kanagawa, zenbones, vague).

### Custom Keymaps
- `<C-d>/<C-u>`: Page down/up with recentering (init.lua:76-77)
- `<C-h/j/k/l>`: Window navigation (init.lua:98-101)
- `<Esc>`: Clear search highlights (init.lua:81)

## Development Notes

### Modifying Configuration
The main configuration is in `init.lua`. When making changes:
1. Restart Neovim or `:source $MYVIMRC`
2. Run `:Lazy sync` if plugins were added/removed
3. Run `:Mason` to install new LSP servers or formatters

### Adding New LSP Servers
1. Add server to the `servers` table (init.lua:635-663)
2. Add to `ensure_installed` if needed (init.lua:678-681)
3. Restart Neovim - mason-tool-installer will auto-install

### Adding Formatters
1. Install via Mason or ensure it's in PATH
2. Add to `formatters_by_ft` table (init.lua:731-742)
3. Optionally add to `ensure_installed` (init.lua:679)

### Plugin Organization
- Custom user plugins: Add to `lua/custom/plugins/init.lua` or create new files in that directory
- Kickstart example plugins: Located in `lua/kickstart/plugins/` (currently commented out/unused)
