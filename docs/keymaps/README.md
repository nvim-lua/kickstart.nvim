# ⌨️ Keymaps Reference

Complete guide to all keymaps in this configuration, organized by category.

---

## 📋 Quick Navigation

- **[Core Keymaps](core.md)** - Leader-key organization (buffer, window, search, git, etc.)
- **[LSP Keymaps](lsp.md)** - Language Server Protocol commands
- **[Plugin Keymaps](plugins.md)** - Telescope, Neo-tree, Git, Debug
- **[Duplicates Guide](duplicates.md)** - Understanding multiple keys for same action
- **[Consistency Guide](consistency.md)** - Cross-plugin key patterns

---

## 🎯 Keymap Philosophy

### 1. Leader-Based Organization
Almost all custom keymaps start with `<Leader>` (Space key):
- `<Leader>b` - **Buffer** operations
- `<Leader>s` - **Search** (Telescope)
- `<Leader>f` - **Flutter** (Dart files)
- `<Leader>r` - **Rust** operations
- `<Leader>d` - **Debug** commands
- `<Leader>g` - **Git** operations
- And more...

### 2. Mnemonic Design
Keys are chosen to be memorable:
- `<Leader>sf` = **S**earch **F**iles
- `<Leader>bb` = **B**uffer **B**rowse
- `<Leader>gg` = Open Lazy**G**it
- `<Leader>db` = **D**ebug **B**reakpoint

### 3. Which-key Discovery
Press `<Leader>` and wait - a menu shows all available commands!

### 4. Consistent Across Plugins
Same keys work the same way everywhere:
- `Ctrl-x` = Horizontal split (Telescope, Neo-tree)
- `Ctrl-v` = Vertical split (Telescope, Neo-tree)
- `Ctrl-t` = New tab (Telescope, Neo-tree)
- `?` = Show help (Telescope, Neo-tree)

---

## 🗺️ Keymap Categories

### Core Editor
| Prefix | Category | Example |
|--------|----------|---------|
| `<Leader>b` | Buffer operations | `<Leader>bd` = Delete buffer |
| `<Leader>w` | Window operations | `<Leader>wv` = Vertical split |
| `<Leader>u` | UI toggles | `<Leader>uw` = Toggle wrap |
| `<Leader>s` | Search/Telescope | `<Leader>sf` = Find files |
| `<Leader>g` | Git operations | `<Leader>gg` = LazyGit |

### LSP (Language Features)
| Prefix | Category | Example |
|--------|----------|---------|
| `gr*` | Go to... | `grd` = Go to definition |
| `K` | Hover | `K` = Show documentation |
| `<Leader>c` | Code | `<Leader>ca` = Code actions |

### Debug
| Prefix | Category | Example |
|--------|----------|---------|
| `<Leader>d` | Debug commands | `<Leader>db` = Breakpoint |
| `F5-F12` | Debug quick keys | `F5` = Continue |

### Language-Specific
| Prefix | Language | Example |
|--------|----------|---------|
| `<Leader>f` | Flutter/Dart | `<Leader>fr` = Run app |
| `<Leader>r` | Rust | `<Leader>ra` = Code actions |
| `<Leader>rc` | Rust Crates | `<Leader>rct` = Toggle |
| `<Leader>p` | Python | `<Leader>pr` = Run |
| `<Leader>v` | Svelte | `<Leader>vf` = Format |

---

## 📚 Detailed Documentation

### [Core Keymaps](core.md)
Complete reference for all leader-key bindings:
- Buffer management
- Window operations
- Search/Telescope
- Git integration
- UI toggles
- Session management

### [LSP Keymaps](lsp.md)
Language Server Protocol commands that work in all languages:
- Go to definition, references, implementation
- Hover documentation
- Rename symbol
- Code actions
- Signature help
- Diagnostics navigation

### [Plugin Keymaps](plugins.md)
Plugin-specific keymaps:
- **Telescope**: Fuzzy finding, live grep, file browser
- **Neo-tree**: File explorer navigation and operations
- **Git**: Gitsigns hunks, staging, blame
- **Debug**: nvim-dap debugging commands
- **Mini.nvim**: Surround, comments, pairs

### [Duplicates Guide](duplicates.md)
Understanding why some actions have multiple keymaps:
- Vim defaults + modern alternatives
- Function keys + leader keys for debugging
- Single keys + Ctrl combos for consistency
- Default plugin keys + consistent alternatives

### [Consistency Guide](consistency.md)
Cross-plugin key patterns:
- Same split/tab keys in Telescope and Neo-tree
- Consistent navigation patterns
- Unified help access

---

## 🎓 Learning Strategy

### Week 1: Essential Commands
Focus on these 10 keymaps:
1. `<Leader>sf` - Find files
2. `<Leader>sg` - Search text (grep)
3. `<Leader>bb` - Browse buffers
4. `\` - Toggle file explorer
5. `gd` - Go to definition
6. `K` - Show documentation
7. `<Leader>ca` - Code actions
8. `<Leader>gg` - Git interface
9. `<C-h/l>` - Switch windows
10. `<Leader>sc` - Open cheatsheet!

### Week 2: Expand Your Arsenal
Add these:
- `<Leader>s/` - Search in open files
- `<Leader>bd` - Delete buffer
- `<Leader>wv` - Split vertical
- `gr` - Find references
- `[d` / `]d` - Next/prev diagnostic

### Ongoing: One Per Week
Pick ONE new keymap each week from the [full documentation](core.md) and practice it until it's muscle memory.

---

## 🔍 Finding Keymaps

### In-Editor Tools
```vim
" Comprehensive searchable cheatsheet
<Leader>sc

" Search all keymaps with Telescope
<Leader>sk

" Which-key command palette
<Leader>sK

" Quick fuzzy search
<Leader>?

" Press any prefix and wait
<Leader>  " Shows all leader keymaps
g         " Shows all 'go to' commands
[         " Shows all 'next' commands
]         " Shows all 'previous' commands
```

### By Category
- **Buffer commands**: `<Leader>b` (then wait for menu)
- **Search commands**: `<Leader>s` (then wait)
- **Git commands**: `<Leader>g` (then wait)
- **Debug commands**: `<Leader>d` (then wait)

### By Plugin
Inside a plugin (like Telescope or Neo-tree), press `?` for help.

---

## 💡 Tips

### Discovering Features
1. Press `<Leader>` and wait - explore the which-key menu
2. Open cheatsheet with `<Leader>sc` and search
3. Check plugin-specific help with `?`

### Customizing Keymaps
See [Customization Guide](../customization.md) to:
- Change existing keymaps
- Add your own keymaps
- Disable unwanted keymaps

### Resolving Conflicts
If a keymap doesn't work:
```vim
:verbose map <Leader>sf
:checkhealth which-key
```

---

## 📖 External Resources

- [Vim Cheat Sheet](https://vim.rtorr.com/)
- [Interactive Vim Tutorial](https://www.openvim.com/)
- [Practical Vim Book](https://pragprog.com/titles/dnvim2/practical-vim-second-edition/)

---

<div align="center">

**Master your keymaps, master your editor!**

[Core Keymaps →](core.md) | [LSP Keymaps →](lsp.md) | [Plugin Keymaps →](plugins.md)

[Back to Documentation](../README.md)

</div>
