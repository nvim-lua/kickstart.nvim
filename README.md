# Neovim Development Environment

A highly opinionated, single-file Neovim configuration built for performance, transparency, and a terminal-native workflow.

## Philosophy

This configuration is intentionally streamlined. It avoids the bloat of heavy distributions in favor of a clear, maintainable `init.lua` that acts as its own documentation. 

* **Built for Infrastructure & Backend:** Tuned specifically for a DevOps engineering workflow, with deep integrations for Go, Terraform, Bicep, and bash scripting.
* **Terminal-Native:** Optimized for fast, keyboard-driven navigation. No unnecessary GUI abstractions.
* **Radical Transparency:** Every line of code is meant to be understood. The configuration is a foundation, ready to be scaled or refactored as tooling requirements evolve.

## Prerequisites

This setup expects a modern Unix environment. It is primarily developed and tested on Arch Linux.

Ensure you have the following system dependencies installed so tools like Telescope and Treesitter compile correctly:

```bash
sudo pacman -S --needed neovim gcc make git ripgrep fd tree-sitter-cli unzip xclip
```

## Installation

**1. Prepare the Environment**
Back up any existing configuration and clear the local share directory to avoid plugin conflicts.
```bash
mv ~/.config/nvim ~/.config/nvim.bak
rm -rf ~/.local/share/nvim
```

**2. Clone the Repository**
```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/kickstart.nvim.git ~/.config/nvim
```

**3. Bootstrap**
Launch Neovim. The package manager will automatically pull and compile all plugins on the first run.
```bash
nvim
```

## Core Stack & Integrations

* **LSP & Linting:** Native Neovim LSP setup configured for `gopls`, `terraform-ls`, and `bicep-lsp`.
* **Fuzzy Finding:** Telescope.nvim powered by `ripgrep` and `fd` for instant project-wide navigation.
* **Parsing:** Treesitter for high-performance syntax highlighting and structural code manipulation.

## Management & Updates

* **Inspect State:** Run `:lua vim.pack.update(nil, { offline = true })`
* **Apply Updates:** Run `:lua vim.pack.update()` (`:write` to apply, `:quit` to cancel)
