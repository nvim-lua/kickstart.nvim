# n-ide.nvim

This is my Neovim configuration for using it as an IDE. It’s forked from kickstart.nvim. Feel free to use it however you like, but I strongly recommend checking out the kickstart.nvim repository to build your own setup, it’s very easy to get started and understand.

## Installation

### Install Neovim

This was built to be used on an Arch-based distro. I have no intention of porting it to other operating systems. If you are using a different environment, I highly recommend checking out the kickstart.nvim repository — they support Windows, macOS, and other Linux distributions.
(It will probably work on any popular modern distro as long as you meet the requirements listed below.)

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, this can be turned off easily 
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

#### Arch Requeriments

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```

### Install Kickstart

> [!NOTE]
> [Backup](#FAQ) your previous configuration (if any exists)

#### Clone kickstart.nvim

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```
### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
the current plugin status. Hit `q` to close the window.

### FAQ

* What should I do if I already have a pre-existing Neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
