### Introduction

A starting point for Neovim that is:

* Small (~370 lines)
* Single-file
* Documented
* Modular

Kickstart.nvim targets *only* the latest ['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest ['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim. If you are experiencing issues, please make sure you have the latest versions.

This repo is meant to be used as a starting point for a user's own configuration; remove the things you don't use and add what you miss. This configuration serves as the reference configuration for the [lspconfig wiki](https://github.com/neovim/nvim-lspconfig/wiki).

### Installation

* Backup your previous configuration
* Copy and paste the kickstart.nvim `init.lua` into `$HOME/.config/nvim/init.lua`
* Start Neovim (`nvim`) and run `:PackerInstall` - ignore any error message about missing plugins, `:PackerInstall` will fix that shortly
* Restart Neovim

### Configuration

You could directly modify the `init.lua` file with your personal customizations. This option is the most straightforward, but if you update your config from this repo, you may need to reapply your changes.

An alternative approach is to create a separate `custom.plugins` module to register your own plugins. In addition, you can handle further customizations in the `/after/plugin/` directory (see `:help load-plugins`). See the following examples for more information. Leveraging this technique should make upgrading to a newer version of this repo easier. 

#### Example `plugins.lua`

The following is an example of a `plugins.lua` module (located at `$HOME/.config/nvim/lua/custom/plugins.lua`) where you can register your own plugins. 

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

For further customizations, you can add a file in the `/after/plugin/` folder (see `:help load-plugins`) to include your own options, keymaps, autogroups, and more. The following is an example `defaults.lua` file (located at `$HOME/.config/nvim/after/plugin/defaults.lua`).

```lua
vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
```

### Contribution

Pull-requests are welcome. The goal of this repo is not to create a Neovim configuration framework, but to offer a starting template that shows, by example, available features in Neovim. Some things that will not be included:

* Custom language server configuration (null-ls templates)
* Theming beyond a default colorscheme necessary for LSP highlight groups
* Lazy-loading. Kickstart.nvim should start within 40 ms on modern hardware. Please profile and contribute to upstream plugins to optimize startup time instead.

Each PR, especially those which increase the line count, should have a description as to why the PR is necessary.
