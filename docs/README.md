# 📚 Complete Documentation Guide

Welcome to the comprehensive documentation for this Neovim configuration. This guide is organized to help you progress from beginner to advanced user.

---

## 🗺️ Documentation Structure

### 🚀 Getting Started
**Start here if you're new or just installed the config**

- [**Installation**](getting-started/installation.md) - Step-by-step setup guide
- [**First Steps**](getting-started/first-steps.md) - Your first hour with this config
- [**Quick Reference**](getting-started/quick-reference.md) - Essential commands cheat sheet
- [**Philosophy**](getting-started/philosophy.md) - Design principles and organization

### ⌨️ Keymaps
**Complete keymap documentation with examples**

- [**Overview**](keymaps/README.md) - Keymap organization philosophy
- [**Core Keymaps**](keymaps/core.md) - Leader key bindings (buffer, window, search, etc.)
- [**LSP Keymaps**](keymaps/lsp.md) - Language Server Protocol commands
- [**Plugin Keymaps**](keymaps/plugins.md) - Telescope, Neo-tree, Git, etc.
- [**Debug Keymaps**](keymaps/debug.md) - Debugging commands
- [**Duplicates Guide**](keymaps/duplicates.md) - Understanding multiple keys for same action
- [**Consistency Guide**](keymaps/consistency.md) - Cross-plugin key patterns

### 🔌 Plugins
**Understanding each plugin and how to use it**

- [**Overview**](plugins/README.md) - All plugins explained
- [**Core Plugins**](plugins/core.md) - Telescope, Neo-tree, which-key, lazy.nvim
- [**Editor Plugins**](plugins/editor.md) - TreeSitter, mini.nvim, autopairs, etc.
- [**LSP & Completion**](plugins/lsp.md) - Language servers, nvim-cmp, snippets
- [**Debug Adapter**](plugins/debug.md) - nvim-dap setup and usage
- [**Git Integration**](plugins/git.md) - Gitsigns, LazyGit, fugitive
- [**UI Enhancements**](plugins/ui.md) - Colorscheme, statusline, bufferline

### 💻 Language Setup
**Language-specific configuration and features**

- [**Overview**](languages/README.md) - All supported languages
- [**Flutter/Dart**](languages/flutter-dart.md) - Flutter tools, device management, hot reload
- [**Rust**](languages/rust.md) - rust-analyzer, Crates.io integration
- [**Python**](languages/python.md) - Pyright, virtual environments, testing
- [**Svelte**](languages/svelte.md) - Svelte LSP, web development
- [**TypeScript/JavaScript**](languages/typescript.md) - tsserver, ESLint, Prettier
- [**Go**](languages/go.md) - gopls, testing, debugging
- [**Other Languages**](languages/others.md) - Lua, JSON, YAML, Markdown, etc.

### 🎓 Vim Mastery
**Progressive learning path to master Vim**

- [**Overview**](vim-mastery/README.md) - Learning philosophy and roadmap
- [**Week 1: Motion Basics**](vim-mastery/week-01-motions.md) - hjkl, word motions, searching
- [**Week 2: Text Objects**](vim-mastery/week-02-text-objects.md) - iw, ap, at, etc.
- [**Week 3: Advanced Editing**](vim-mastery/week-03-advanced.md) - Visual mode, macros intro
- [**Week 4: Macros & Registers**](vim-mastery/week-04-macros.md) - Recording and replay
- [**Week 5: Command Line**](vim-mastery/week-05-cmdline.md) - Ex commands, ranges, substitution
- [**Week 6: Windows & Tabs**](vim-mastery/week-06-windows.md) - Managing your workspace
- [**Tips & Tricks**](vim-mastery/tips-and-tricks.md) - Productivity boosters
- [**Workflows**](vim-mastery/workflows.md) - Real-world editing patterns
- [**Advanced Topics**](vim-mastery/advanced.md) - Vim script, Lua, custom commands

### 🛠️ Advanced Topics

- [**Customization**](customization.md) - Make this config your own
- [**Plugin Development**](plugin-development.md) - Create your own plugins
- [**Performance Tuning**](performance.md) - Optimize startup time
- [**Troubleshooting**](troubleshooting.md) - Common issues and solutions
- [**Migration Guide**](migration.md) - Coming from other configs
- [**FAQ**](faq.md) - Frequently asked questions

---

## 📖 How to Use This Documentation

### For Beginners
1. Start with [Getting Started](getting-started/README.md)
2. Learn [Quick Reference](getting-started/quick-reference.md) commands
3. Follow [Vim Mastery Week 1](vim-mastery/week-01-motions.md)
4. Use the [in-editor cheatsheet](#in-editor-help) constantly

### For Intermediate Users
1. Review [Keymaps documentation](keymaps/README.md) to discover new commands
2. Explore [Plugin guides](plugins/README.md) for advanced features
3. Continue [Vim Mastery](vim-mastery/README.md) progression
4. Learn language-specific features in [Languages](languages/README.md)

### For Advanced Users
1. Study [Customization](customization.md) to extend the config
2. Optimize with [Performance Tuning](performance.md)
3. Master [Advanced Topics](vim-mastery/advanced.md)
4. Contribute improvements back to the project

---

## 🎯 In-Editor Help

You don't need to leave Neovim to access help:

### Built-in Cheatsheet
- `<Leader>sc` - Comprehensive searchable cheatsheet (200+ keymaps)
- `<Leader>sk` - Telescope keymap search
- `<Leader>?` - Quick keymap fuzzy search
- `<Leader>sK` - Which-key command palette

### Context-Sensitive Help
- `K` - Hover documentation (LSP)
- `<Leader>k` - Signature help
- `?` (in Telescope/Neo-tree) - Show plugin-specific help
- `:help <topic>` - Vim's built-in help system

### Discovery Tools
- Press `<Leader>` and wait - which-key shows all available keymaps
- Press `g` and wait - see all "go to" commands
- Press `]` or `[` and wait - see all next/previous commands

---

## 💡 Learning Philosophy

This documentation follows a **progressive disclosure** approach:

1. **Start Simple**: Basic commands to be productive immediately
2. **Build Gradually**: Add one new technique per week
3. **Practice Deliberately**: Focus on mastering before moving on
4. **Apply Immediately**: Use new skills in real work
5. **Iterate**: Return to earlier topics with new understanding

### The One-Trick-Per-Week Method

Instead of trying to learn everything at once:
- Pick ONE new command/technique each week
- Use it consciously until it becomes muscle memory
- Track your progress in [Vim Mastery](vim-mastery/README.md)
- After a year, you'll have 52 new tricks!

---

## 🗺️ Learning Paths

### Path 1: Productive in One Day
*Goal: Get work done immediately*

1. [Installation](getting-started/installation.md) - 30 min
2. [Quick Reference](getting-started/quick-reference.md) - 15 min
3. [Core Keymaps](keymaps/core.md) - Learn `<Leader>sf`, `<Leader>sg`, `<Leader>bb`
4. Start coding with LSP features (K, gra, gd)

### Path 2: Vim Proficiency in 6 Weeks
*Goal: Become efficient with Vim motions*

1. Week 1: [Motion Basics](vim-mastery/week-01-motions.md)
2. Week 2: [Text Objects](vim-mastery/week-02-text-objects.md)
3. Week 3: [Advanced Editing](vim-mastery/week-03-advanced.md)
4. Week 4: [Macros & Registers](vim-mastery/week-04-macros.md)
5. Week 5: [Command Line](vim-mastery/week-05-cmdline.md)
6. Week 6: [Windows & Tabs](vim-mastery/week-06-windows.md)

### Path 3: Master All Features
*Goal: Unlock the full power of this config*

1. Complete Path 2 (Vim Proficiency)
2. Deep dive into [All Plugins](plugins/README.md)
3. Master your primary language setup
4. Learn [Advanced Workflows](vim-mastery/workflows.md)
5. Customize and extend ([Customization Guide](customization.md))

---

## 🎓 Recommended External Resources

### Books
- **Practical Vim** by Drew Neil - The best Vim book
- **Modern Vim** by Drew Neil - Neovim-specific features
- **Learning the Vi and Vim Editors** - Comprehensive reference

### Video Courses
- **ThePrimeagen's Vim Course** - Entertaining and informative
- **Vim Casts** - Short, focused video tutorials
- **TJ DeVries' Neovim YouTube** - Creator of kickstart.nvim

### Interactive Learning
- **vimtutor** - Run `:Tutor` in Neovim
- **Vim Adventures** - Game to learn Vim
- **OpenVim** - Interactive tutorial

### Community
- **r/neovim** - Reddit community
- **Neovim Discourse** - Official forum
- **Matrix/Discord** - Real-time chat

---

## 📝 Documentation Conventions

### Notation
- `<Leader>` - Your leader key (default: Space)
- `<C-x>` - Control + x
- `<M-x>` - Alt/Meta + x
- `<CR>` - Enter/Return key
- `{motion}` - Any motion command (w, e, $, etc.)
- `[count]` - Optional number prefix

### Visual Cues
- 💡 **Tip** - Helpful suggestion
- ⚠️ **Warning** - Important caution
- 📌 **Note** - Additional information
- 🎯 **Pro Tip** - Advanced technique
- 🔍 **Example** - Practical demonstration

---

## 🔄 Keeping Documentation Updated

This documentation evolves with the configuration:

- **Check for updates**: `git pull` in `~/.config/nvim`
- **Version**: Documentation matches config version
- **Feedback**: Open issues for unclear docs
- **Contribute**: Submit PRs for improvements

---

## 🎯 Quick Navigation

### By Topic
- **Need to find a file?** → [Telescope Guide](plugins/core.md#telescope)
- **Want to understand a keymap?** → [Keymaps Overview](keymaps/README.md)
- **LSP not working?** → [Troubleshooting LSP](troubleshooting.md#lsp-issues)
- **Adding a language?** → [Language Setup](languages/README.md)
- **Config too slow?** → [Performance Tuning](performance.md)

### By Skill Level
- **Beginner** → [Getting Started](getting-started/README.md)
- **Intermediate** → [Vim Mastery](vim-mastery/README.md)
- **Advanced** → [Customization](customization.md)

### By Plugin
- [Telescope](plugins/core.md#telescope)
- [Neo-tree](plugins/core.md#neo-tree)
- [which-key](plugins/core.md#which-key)
- [nvim-cmp](plugins/lsp.md#completion)
- [nvim-dap](plugins/debug.md)
- [Gitsigns](plugins/git.md)

---

<div align="center">

**Happy Coding! 🚀**

[Back to Main README](../README.md) | [Get Started →](getting-started/README.md)

</div>
