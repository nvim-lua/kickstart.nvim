# mgua's kickstart.nvim

# Introduction

This project is heavily based on TJ DeVries amazing work to promote Neovim adoption and usage.
Please see the original project nvim-lua/kickstart.nvim
In my neovim journey I recently migrated from vimscript to lua, and I am still in the process of adjusting my setup.

I am working to make this kickstart a standard for my development team, which is easy to deploy on Windows Linux amd MacOSX systems.
Kickstart is just a configuration procedure. It requires to have several components installed and prepared. In the following notes I will list the preparation activities to be performed on the different operating systems.
A possible alternative approach is to use a neovim distribution, like 
- [LazyVim](https://www.lazyvim.org/): maintained by @folke (the author of lazy.nvim package manager)

## Linux

### Neovim preparation and Installation for Linux

#### Ubuntu
from root:
- apt update
- apt upgrade
- apt install software-properties-common
- add-apt-repository ppa:neovim-ppa/stable
- apt update
- apt install ripgrep fd-find
- apt install neovim

#### Kali
from root:
- apt update
- apt upgrade
- apt install ripgrep fd-find 
- cd
- mkdir neovim
- cd neovim
- curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
- chmod +x nvim.appimage
- cp nvim.appimage /usr/bin/
- ln -s /usr/bin/nvim.appimage /usr/bin/nvim
- (To be completed)

#### Almalinux
from root:
- yum update
- yum install ripgrep fd-find
- yum install neovim

* Kickstart Configuration (in non privileged user context)*
- Exit from nvim if open
- cd $HOME/.config
- mv nvim nvim_old
- mkdir nvim
- cd nvim
- git clone https://github.com/mgua/kickstart.nvim.git .

Start nvim now, and you should see the automatic download and updates by lazy

--

### Windows

## Neovim preparation and Installation for windows
actions to be executed from administrator user:
1. Chocolatey package manager installation (see https://chocolatey.org/)
- run the following from powershell admin
- Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
- close and reopen admin window
2. Winget package manager installation ( see https://learn.microsoft.com/en-us/windows/package-manager/winget/ )
- install winget from microsoft store
3. from an administrator console, execute:
- 


## Kickstart Configuration (in non privileged user context)
- Exit from nvim if open
- cd $HOME/App.config
- mv nvim nvim_old
- mkdir nvim
- cd nvim
- git clone https://github.com/mgua/kickstart.nvim.git .

--


Kickstart.nvim targets *only* the latest ['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest ['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim. If you are experiencing issues, please make sure you have the latest versions.

* Backup your previous configuration
* (Recommended) Fork this repo (so that you have your own copy that you can modify).
* Clone the kickstart repo into `$HOME/.config/nvim/` (Linux/Mac) or `~/AppData/Local/nvim/` (Windows)
  * If you don't want to include it as a git repo, you can just clone it and then move the files to this location
* Start Neovim (`nvim`) and allow `lazy.nvim` to complete installation.
* Restart Neovim
* **You're ready to go!**

Additional system requirements:
- Make sure to review the readmes of the plugins if you are experiencing errors. In particular:
  - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
- See as well [Windows Installation](#Windows-Installation)

### Configuration And Extension

* Inside of your fork, feel free to modify any file you like! It's your fork!
* Then there are two primary configuration options available:
  * Include the `lua/kickstart/plugins/*` files in your configuration.
  * Add new configuration in `lua/custom/plugins/*` files, which will be auto sourced using `lazy.nvim`
    * NOTE: To enable this, you need to uncomment `{ import = 'custom.plugins' }` in your `init.lua`

You can also merge updates/changes from the repo back into your fork, to keep up-to-date with any changes for the default configuration

#### Example: Adding an autopairs plugin

In the file: `lua/custom/plugins/autopairs.lua`, add:

```lua
-- File: lua/custom/plugins/autopairs.lua

return {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup {}
  end,
}
```


This will automatically install `nvim-autopairs` and enable it on startup. For more information, see documentation for [lazy.nvim](https://github.com/folke/lazy.nvim).

#### Example: Adding a file tree plugin

In the file: `lua/custom/plugins/filetree.lua`, add:

```lua
-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {}
  end,
}
```

This will install the tree plugin and add the command `:Neotree` for you. You can explore the documentation at [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) for more information.

#### Example: Adding a file to change default options

To change default options, you can add a file in the `/after/plugin/` folder (see `:help load-plugins`) to include your own options, keymaps, autogroups, and more. The following is an example `defaults.lua` file (located at `$HOME/.config/nvim/after/plugin/defaults.lua`).

```lua
vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
```

### Contribution

Pull-requests are welcome. The goal of this repo is not to create a Neovim configuration framework, but to offer a starting template that shows, by example, available features in Neovim. Some things that will not be included:

* Custom language server configuration (null-ls templates)
* Theming beyond a default colorscheme necessary for LSP highlight groups

Each PR, especially those which increase the line count, should have a description as to why the PR is necessary.

### FAQ

* What should I do if I already have a pre-existing neovim configuration?
  * You should back it up, then delete all files associated with it.
  * This includes your existing init.lua and the neovim files in `~/.local` which can be deleted with `rm -rf ~/.local/share/nvim/`
  * You may also want to look at the [migration guide for lazy.nvim](https://github.com/folke/lazy.nvim#-migration-guide)
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling) information
* Are there any cool videos about this plugin?
  * Current iteration of kickstart (coming soon)
  * Here is one about the previous iteration of kickstart: [video introduction to Kickstart.nvim](https://youtu.be/stqUbv-5u2s).

### Windows Installation

Installation may require installing build tools, and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake, and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```

