### Introduction

A starting point for neovim that is:

* Small (~325 lines)
* Single-file
* Documented
* Modular

Kickstart targets *only* the latest stable neovim release (0.7) and the nightly.

This repo is meant to be used as a starting point for a user's own configuration; remove the things you don't use and add what you miss. This configuration serves as the reference configuration for the [lspconfig wiki](https://github.com/neovim/nvim-lspconfig/wiki).

### Installation

* Backup your previous configuration
* Copy and paste the kickstart.nvim `init.lua` into `$HOME/.config/nvim/init.lua`
* start neovim (`nvim`) and run `:PackerInstall`, ignore any error message about missing plugins, `:PackerInstall` will fix that shortly.
* restart neovim

### Configuration

You could directly modify the `init.lua` file with your personal customizations. This option is the most straightforward, but if you update your config from this repo, you may need to reapply your changes.

An alternative approach is to create a separate `custom.plugins` module to register your own plugins. In addition, you can handle further customizations in a `after/plugin/defaults.lua` file. See the following examples for more information. Leveraging these files should make upgrading to a newer version of this repo easier. 

#### Example `plugins.lua`

The following is an example of a `plugins.lua` file (located at `$HOME/.config/nvim/lua/custom/plugins.lua`) where you can register you own plugins. 

```lua
return function(use)
  use({
    "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
      end
  })
end
```

#### Example `defaults.lua`

The following is an example `defaults.lua` file (localed at `$HOME/.config/nvim/after/plugin/defaults.lua`) where you can define your own options, keymaps, autogroups, and more.

```lua
vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
```

### Contribution

Pull-requests are welcome. The goal of this repo is not to create a neovim configuration framework, but to offer a starting template that shows, by example, available features in neovim. Some things that will not be included:

* Custom language server configuration (null-ls templates)
* Theming beyond a default colorscheme necessary for LSP highlight groups
* Lazy-loading. Kickstart.nvim should start within 40 ms on modern hardware. Please profile and contribute to upstream plugins to optimize startup time instead.

Each PR, especially those which increase the line count, should have a description as to why the PR is necessary.
