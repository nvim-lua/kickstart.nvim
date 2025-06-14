# Neovim Keybindings Reference

A comprehensive reference for all keybindings in this Neovim configuration, organized by prefix and functionality.

## General Operations

- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>Q` - Force quit all
- `<leader>W` - Save and quit
- `<leader>/` - Clear search highlights
- `<Esc>` - Clear highlights

## Navigation

### Window Navigation

- `<C-h>` - Move focus to the left window
- `<C-j>` - Move focus to the down window
- `<C-k>` - Move focus to the up window
- `<C-l>` - Move focus to the right window

### Window Management (`<leader>w`)

- `<leader>wv` - Split window vertically
- `<leader>ws` - Split window horizontally
- `<leader>wq` - Close current window
- `<leader>wo` - Close other windows

### Window Resizing

- `<M-Up>` - Increase window height
- `<M-Down>` - Decrease window height
- `<M-Left>` - Decrease window width
- `<M-Right>` - Increase window width

### Tab Management (`<leader>t`)

- `<leader>tn` - New tab
- `<leader>to` - New tab with file
- `<leader>tc` - Close tab
- `<C-PgDn>` - Next tab
- `<C-PgUp>` - Previous tab

### Buffer Navigation (`<leader>b`)

- `<leader><leader>` - Find buffers
- `<leader>bd` - Delete buffer
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bp` - Pick buffer
- `<leader>bc` - Pick buffer to close
- `<leader>bh` - Previous buffer
- `<leader>bl` - Next buffer
- `<leader>bH` - Move buffer left
- `<leader>bL` - Move buffer right
- `<leader>b1-9` - Go to buffer 1-9
- `<A-1-9>` - Go to buffer 1-9

## File Operations (`<leader>f`)

### File Search (Telescope)

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fr` - Recent files
- `<leader>fc` - Grep current string
- `<leader>fk` - Find keymaps
- `<leader>fd` - Search diagnostics
- `<leader>fw` - Search current buffer

### Git Search (`<leader>fg`)

- `<leader>fgc` - Git commits
- `<leader>fgb` - Git branches
- `<leader>fgs` - Git status
- `<leader>fgt` - Git stash

### File Explorer

- `<leader>e` - Open file explorer

## Editing

### Line Movement

- `<A-j>` - Move line down
- `<A-k>` - Move line up
- `<A-j>` (visual) - Move selection down
- `<A-k>` (visual) - Move selection up

### Indentation

- `<` (visual) - Decrease indent
- `>` (visual) - Increase indent

## Terminal (`<leader>tt`)

- `<leader>tt` - Toggle terminal
- `<leader>tf` - Toggle floating terminal
- `<leader>th` - Toggle horizontal terminal
- `<leader>tv` - Toggle vertical terminal
- `<Esc>` (terminal) - Exit terminal mode

## Diagnostics (`<leader>x`)

- `<leader>xx` - Toggle trouble
- `<leader>xw` - Toggle workspace diagnostics
- `<leader>xd` - Toggle document diagnostics / Open diagnostic float
- `<leader>xq` - Toggle quickfix
- `<leader>xl` - Toggle location list / Open diagnostic list
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

## Plugin-specific Keybindings

### Harpoon (`<leader>h`)

- `<leader>ha` - Add file to harpoon
- `<leader>hh` - Toggle quick menu
- `<leader>h1-9` - Jump to file 1-9

### LeetCode (`<leader>l`)

- `<leader>ll` - Open LeetCode
- `<leader>ld` - Daily Challenge
- `<leader>lr` - Random Problem
- `<leader>ls` - Submit Solution
- `<leader>lt` - Test Solution
- `<leader>lm` - LeetCode Menu
- `<leader>li` - Problem Info
- `<leader>lc` - Toggle Console
- `<leader>la` - Switch Tab

### Neorg (`<leader>n`)

- `<leader>ni` - Neorg index
- `<leader>nr` - Return from workspace
- `<leader>nt` - Toggle concealer
- `<leader>nm` - Inject metadata

#### Neorg Journal (`<leader>nj`)

- `<leader>njj` - Today's journal entry
- `<leader>njt` - Tomorrow's journal entry
- `<leader>njy` - Yesterday's journal entry

#### Neorg Workspace (`<leader>nw`)

- `<leader>nwn` - Switch to notes workspace
- `<leader>nww` - Switch to work workspace
- `<leader>nwp` - Switch to personal workspace

#### Neorg Export (`<leader>ne`)

- `<leader>neh` - Export to HTML
- `<leader>nem` - Export to Markdown
- `<leader>nep` - Export to PDF

### LSP (`<leader>ls`)

- `<leader>lsr` - Rename symbol
- `<leader>lsa` - Code actions
- `<leader>lsf` - Format document
- `<leader>lsd` - Go to definition
- `<leader>lst` - Go to type definition
- `<leader>lsD` - Go to declaration
- `<leader>lsi` - Go to implementation
- `<leader>lsr` - Go to references

### Test (`<leader>te`)

- `<leader>ter` - Run test
- `<leader>tes` - Run test suite
- `<leader>tef` - Run test file
- `<leader>tel` - Run last test

### Code/Copilot (`<leader>c`)

- Various code and Copilot-related commands
