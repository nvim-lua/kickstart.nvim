# Neo-tree File Explorer Cheat Sheet

## Opening/Closing
- `\` - Toggle Neo-tree reveal (show tree with current file highlighted)
- `q` - Close Neo-tree window
- `<Esc>` - Cancel/close preview or Neo-tree window

## Navigation
- `j` / `k` - Move down/up in the file list
- `l` - Focus preview window
- `<CR>` (Enter) - Open file or toggle directory expand/collapse
- `<Space>` - Toggle directory expand/collapse
- `<Backspace>` - Navigate up one directory level
- `.` - Set current directory as root

## Directory Expand/Collapse
- `<Space>` - Toggle expand/collapse directory
- `<CR>` (Enter) - Open file OR toggle directory
- `C` - Close node (collapse directory)
- `z` - Close all nodes (collapse all directories)

## File Operations
- `a` - Add new file (prompts for name)
- `A` - Add new directory
- `d` - Delete file/directory
- `r` - Rename file/directory
- `c` - Copy (prompts for destination path)
- `m` - Move (prompts for destination path)
- `y` - Copy to clipboard
- `x` - Cut to clipboard
- `p` - Paste from clipboard
- `b` - Rename basename only (keep path)

## File Opening
- `<CR>` - Open in current window
- `s` - Open in vertical split
- `S` - Open in horizontal split
- `t` - Open in new tab
- `w` - Open with window picker

## Display & Navigation
- `H` - Toggle hidden files
- `/` - Fuzzy finder (search files in tree)
- `f` - Filter on submit
- `<C-x>` - Clear filter
- `i` - Show file details
- `R` - Refresh tree
- `?` - Show help (displays all available mappings)

## Git Navigation
- `[g` - Previous git modified file
- `]g` - Next git modified file

## Sorting
Press `o` to show the order by menu, then:
- `oc` - Order by created date
- `od` - Order by diagnostics
- `og` - Order by git status
- `om` - Order by modified date
- `on` - Order by name
- `os` - Order by size
- `ot` - Order by type

## Custom Mappings (from your config)
- `<leader>sf` - Telescope find files in current directory
- `<leader>sg` - Telescope live grep in current directory

## Preview Window
- `P` - Toggle preview window
- `<C-f>` - Scroll preview down
- `<C-b>` - Scroll preview up

## Tips
- Use `?` inside Neo-tree to see all available commands and their keybindings
- The tree follows your current file automatically (if `follow_current_file` is enabled)
- Hidden files (dotfiles) are toggled with `H`
- Most operations can be cancelled with `<Esc>`
