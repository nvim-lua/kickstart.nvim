# 🚀 Getting Started

Welcome! This guide will help you get up and running with this Neovim configuration.

---

## 📚 Guide Structure

1. **[Installation](installation.md)** - Set up Neovim and this configuration
2. **[First Steps](first-steps.md)** - Your first hour with the config
3. **[Quick Reference](quick-reference.md)** - Essential commands you'll use daily
4. **[Philosophy](philosophy.md)** - Understanding the design principles

---

## ⚡ Quick Start (5 Minutes)

### 1. Install Neovim 0.11.4+
```bash
# macOS
brew install neovim

# Ubuntu/Debian
sudo apt install neovim

# Arch Linux
sudo pacman -S neovim
```

### 2. Backup Old Config
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

### 3. Clone This Config
```bash
git clone https://github.com/anupjsebastian/kickstart.nvim.git ~/.config/nvim
```

### 4. Install Dependencies
```bash
# macOS
brew install ripgrep fd

# Ubuntu
sudo apt install ripgrep fd-find

# Arch
sudo pacman -S ripgrep fd
```

### 5. Launch Neovim
```bash
nvim
```

Wait for all plugins to install (watch bottom right corner).

### 6. Verify Everything Works
```vim
:checkhealth
```

---

## 🎯 What You'll Learn

### Immediate (Day 1)
- Opening and editing files
- Basic navigation with Telescope
- Using LSP features (autocomplete, go to definition)
- Essential keymaps you'll use every day

### Short Term (Week 1)
- Vim motion basics
- Using the file explorer (Neo-tree)
- Git integration
- Debugging basics

### Medium Term (Month 1)
- Advanced Vim motions and text objects
- Customizing keymaps
- Language-specific features
- Efficient workflows

### Long Term (Ongoing)
- Mastering Vim commands
- Building your own plugins
- Optimizing your workflow
- One new trick per week approach

---

## 🗺️ Learning Path

```
Installation (15 min)
    ↓
First Steps (30 min) - Learn the absolute basics
    ↓
Quick Reference (ongoing) - Your daily command sheet
    ↓
Week 1: Basic Motions - hjkl, word motions, searching
    ↓
Week 2: Text Objects - iw, ap, it, edit intelligently
    ↓
Week 3: Advanced Editing - Visual mode, macros
    ↓
Continue with Vim Mastery guides...
```

---

## 💡 Key Concepts

### Leader Key = Space
Almost all custom keymaps start with `<Leader>` (the Space key). Press Space and wait - you'll see a menu!

### Which-key is Your Friend
When you press a key prefix (like `<Leader>` or `g`), a menu appears showing all available commands.

### Everything is Searchable
- Files: `<Leader>sf`
- Text: `<Leader>sg`  
- Keymaps: `<Leader>sc`
- Help: `<Leader>sh`

### LSP Powers Your Editing
- `K` - Documentation
- `gd` - Go to definition
- `gr` - Find references
- `gra` - Code actions

---

## 🆘 Getting Help

### In-Editor
- `<Leader>sc` - Comprehensive cheatsheet
- `<Leader>sk` - Search all keymaps
- `<Leader>` (wait) - Which-key menu
- `:help <topic>` - Vim help

### External
- [Full Documentation](../README.md)
- [Troubleshooting Guide](../troubleshooting.md)
- [FAQ](../faq.md)
- [GitHub Issues](https://github.com/anupjsebastian/kickstart.nvim/issues)

---

## ⚠️ Common First-Day Issues

### Plugins Not Installing
```vim
:Lazy sync
```

### LSP Not Working
```vim
:Mason
:LspInfo
:checkhealth
```

### Fonts Look Broken
Install a [Nerd Font](https://www.nerdfonts.com/) and set `vim.g.have_nerd_font = true` in `init.lua`.

### Keymaps Not Working
Check your terminal doesn't intercept keys:
```vim
:checkhealth which-key
```

---

## 🎓 Next Steps

1. Complete [Installation Guide](installation.md)
2. Follow [First Steps Tutorial](first-steps.md)
3. Bookmark [Quick Reference](quick-reference.md)
4. Start [Vim Mastery Week 1](../vim-mastery/week-01-motions.md)

---

<div align="center">

**Ready to dive in?**

[Installation Guide →](installation.md)

[Back to Documentation](../README.md) | [Back to Main README](../../README.md)

</div>
