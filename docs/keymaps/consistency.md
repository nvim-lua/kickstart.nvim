# Keymap Consistency Guide

> **Last Updated:** November 1, 2025  
> **Purpose:** Document consistent keymaps across Telescope and Neo-tree

## 🎯 Consistent Actions

The following keymaps work **identically** in both Telescope and Neo-tree:

### File Opening Actions

| Key | Action | Telescope | Neo-tree |
|-----|--------|-----------|----------|
| `<CR>` or `o` | Open in current window | ✅ | ✅ |
| `<C-x>` | Open in horizontal split | ✅ | ✅ |
| `<C-v>` | Open in vertical split | ✅ | ✅ |
| `<C-t>` | Open in new tab | ✅ | ✅ |

### Navigation

| Key | Action | Telescope | Neo-tree |
|-----|--------|-----------|----------|
| `<C-j>` | Next item/source | ✅ | ✅ |
| `<C-k>` | Previous item/source | ✅ | ✅ |
| `j/k` (normal mode) | Down/Up | ✅ | ✅ |
| `gg/G` (normal mode) | First/Last | ✅ | ✅ |

### Utility

| Key | Action | Telescope | Neo-tree |
|-----|--------|-----------|----------|
| `?` | Show help | ✅ | ✅ |
| `<Esc>` or `q` | Close | ✅ | ✅ (`\\` for Neo-tree) |

### Cross-Plugin Integration

| Key | Action | Context |
|-----|--------|---------|
| `<leader>sf` | Telescope find files | Works in both editor and Neo-tree |
| `<leader>sg` | Telescope live grep | Works in both editor and Neo-tree |

When used in Neo-tree, these commands search from the currently selected directory!

## 📚 Complete Cheatsheet Access

Access the comprehensive cheatsheet with:

```
<leader>sc  - Complete cheatsheet (vim, plugins, language-specific)
<leader>sk  - Search keymaps (Telescope)
<leader>sK  - All keymaps (which-key)
<leader>?   - Quick keymap search
```

## 🎨 Visual Consistency

Both Telescope and Neo-tree now follow the same pattern:
- **Same keys** for same actions
- **Predictable behavior** across interfaces
- **Integrated workflows** (use Telescope from Neo-tree)
- **Help always available** with `?`

## 📝 Quick Reference

### In Telescope:
1. `<C-j/k>` to navigate
2. `<C-x/v/t>` to open in split/vsplit/tab
3. `<CR>` to open in current window
4. `?` for help

### In Neo-tree:
1. `<C-j/k>` to switch sources
2. `<C-x/v/t>` to open in split/vsplit/tab  
3. `<CR>` or `o` to open file
4. `?` for help
5. `<leader>sf/sg` to launch Telescope from current directory

### Both Share:
- Consistent split/tab opening
- Same navigation philosophy
- Integrated search capabilities
- Help on demand
