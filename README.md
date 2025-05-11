# kickstart.nvim/

<a href="https://dotfyle.com/juanmiguelRuaDev/kickstartnvim"><img src="https://dotfyle.com/juanmiguelRuaDev/kickstartnvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/juanmiguelRuaDev/kickstartnvim"><img src="https://dotfyle.com/juanmiguelRuaDev/kickstartnvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/juanmiguelRuaDev/kickstartnvim"><img src="https://dotfyle.com/juanmiguelRuaDev/kickstartnvim/badges/plugin-manager?style=flat" /></a>


## Install Instructions

 > Install requires Neovim 0.9+. Always review the code before installing a configuration.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

> [!NOTE]
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> [!NOTE]
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim

> [!NOTE]
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone git@github.com:juanmiguelRuaDev/kickstart.nvim ~/.config/juanmiguelRuaDev/kickstart.nvim
```

Open Neovim with this config:

```sh
NVIM_APPNAME=juanmiguelRuaDev/kickstart.nvim/ nvim
```

## Plugins

### colorscheme

+ [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim)
+ [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
### comment

+ [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)
+ [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)
### completion

+ [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)
### debugging

+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
### editing-support

+ [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
+ [nvim-treesitter/nvim-treesitter-context](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-context)
### file-explorer

+ [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)
+ [nvim-neo-tree/neo-tree.nvim](https://dotfyle.com/plugins/nvim-neo-tree/neo-tree.nvim)
### formatting

+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)
### fuzzy-finder

+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
### git

+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
+ [kdheepak/lazygit.nvim](https://dotfyle.com/plugins/kdheepak/lazygit.nvim)
### icon

+ [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)
### indent

+ [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)
### keybinding

+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
### lsp

+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
+ [j-hui/fidget.nvim](https://dotfyle.com/plugins/j-hui/fidget.nvim)
+ [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
+ [nvimtools/none-ls.nvim](https://dotfyle.com/plugins/nvimtools/none-ls.nvim)
### lsp-installer

+ [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)
### nvim-dev

+ [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
+ [folke/neodev.nvim](https://dotfyle.com/plugins/folke/neodev.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### snippet

+ [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)
+ [L3MON4D3/LuaSnip](https://dotfyle.com/plugins/L3MON4D3/LuaSnip)
### syntax

+ [echasnovski/mini.surround](https://dotfyle.com/plugins/echasnovski/mini.surround)
+ [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)
+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
### tabline

+ [akinsho/bufferline.nvim](https://dotfyle.com/plugins/akinsho/bufferline.nvim)
### utility

+ [echasnovski/mini.nvim](https://dotfyle.com/plugins/echasnovski/mini.nvim)
## Language Servers

+ html
+ tflint

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


 This readme was generated by [Dotfyle](https://dotfyle.com)
