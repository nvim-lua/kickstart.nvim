### Introduction

A starting point for Neovim that is:

* Small (~325 lines)
* Single-file
* Documented
* Modular

Kickstart.nvim targets *only* the Neovim releases tagged ['stable'](https://github.com/neovim/neovim/releases/tag/stable) and ['nightly'](https://github.com/neovim/neovim/releases/tag/nightly).

This repo is meant to be used as a starting point for a user's own configuration; remove the things you don't use and add what you miss. This configuration serves as the reference configuration for the [lspconfig wiki](https://github.com/neovim/nvim-lspconfig/wiki).

### Installation

* Backup your previous configuration
* Copy and paste the kickstart.nvim `init.lua` into `$HOME/.config/nvim/init.lua`
* Start Neovim (`nvim`) and run `:PackerInstall` - ignore any error message about missing plugins, `:PackerInstall` will fix that shortly
* Restart Neovim

### Contribution

Pull-requests are welcome. The goal of this repo is not to create a Neovim configuration framework, but to offer a starting template that shows, by example, available features in Neovim. Some things that will not be included:

* Custom language server configuration (null-ls templates)
* Theming beyond a default colorscheme necessary for LSP highlight groups
* Lazy-loading. Kickstart.nvim should start within 40 ms on modern hardware. Please profile and contribute to upstream plugins to optimize startup time instead.

Each PR, especially those which increase the line count, should have a description as to why the PR is necessary.
