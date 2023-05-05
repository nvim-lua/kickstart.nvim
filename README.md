# mgua's kickstart.nvim

# Introduction

This project is heavily based on TJ DeVries amazing work to promote Neovim adoption and usage.
Please see the original project nvim-lua/kickstart.nvim

In my neovim journey I recently migrated from vimscript to lua, and I am still in the process of adjusting my setup.

I am working to make this kickstart a standard for my development team, to be deployed on Windows, Linux and MacOSX systems.

Kickstart.nvim is just a configuration procedure. It requires to have several components installed and prepared. 
In the following notes I will list the preparation activities to be performed on the different operating systems.

A possible alternative approach is to use a neovim distribution, like 
- [LazyVim](https://www.lazyvim.org/): maintained by @folke (the author of lazy.nvim package manager)

A specific aspect on which work is needed is the improvement of clipboard integration between neovim running in a terminal session and the operating system from which the user works. While there are several alternative, at the moment I think the best solution is vim-oscyank ( https://github.com/ojroques/vim-oscyank ). This relies on ANSI OSC52 terminal specifications. While this standard is supported in several emulators, it is not ubiquitous. Good news is that is is supported by the new Windows Terminal Emulator. Bad news is that it is apparently unsupported by putty and by mremote.
I can confirm that this works fine also in integration with Microsoft RDP and Citrix workspace. 
(This allows things like opening citrix session towards a remote windows system, from my windows11 client, and from there using microsoft terminal ssh-ing a remote system. From there ssh-ing to a linux system where neovim is installed and where the editing takes place, and having yank correctly send back unicode txt excerpt to my windows11 client.)

With this plugin (not currently integrated in this kickstart) I was able to sucessfully yank large text sections from a neovim session running on a remote system (also across jump-hosts and several network restrictions in between) to my windows local clipboard. Transfer in the other direction is quite trivial and SHIFT-INS usually performs the task.



## Neovim preparation and Installation for Linux
#### Ubuntu
from root:
```
apt update
apt upgrade
apt install software-properties-common
add-apt-repository ppa:neovim-ppa/stable
apt update
apt install ripgrep fd-find git gcc make
apt install neovim
apt install python3 python3-venv python3-pip (for python development) 
cpan install Neovim::Ext (for perl development)
apt install npm (for node javascript development and to support some language servers/parsers)
npm install -g neovim (for node integration)
```

#### Kali
from root:
```
apt update
apt upgrade
apt install ripgrep fd-find git gcc make
cd
mkdir neovim
cd neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
cp nvim.appimage /usr/bin/
ln -s /usr/bin/nvim.appimage /usr/bin/nvim
apt install python3 python3-venv python3-pip (for python development) 
cpan install Neovim::Ext (for perl development)
apt install npm (for node javascript development and to support some language servers/parsers)
npm install -g neovim
npm install -g tree-sitter-cli  (this is needed to execute the :TSInstallFromGrammar <language> command within neovim)
```

#### Almalinux
from root:
```
yum update
yum install ripgrep fd-find git gcc make gcc-c++
yum install neovim
yum install python3 python3-pip (for python development)
cpan install Neovim::Ext (for perl development) 
yum install npm (for node javascript development and to support some language servers/parsers: this brings in nodejs, nodejs-libs)
npm install -g neovim
npm install -g tree-sitter-cli  (this is needed to execute the :TSInstallFromGrammar <language> command within neovim)
```

### Neovim Kickstart Configuration for any linux distribution (in non privileged user context)
- Exit from nvim if open
```
cd $HOME/.config
mv nvim nvim_old
mkdir nvim
cd nvim
git clone https://github.com/mgua/kickstart.nvim.git .
```
- for python developers, create a dedicated environment for nvim:
```
cd
python3 -m venv venv_nvim
source ./venv_nvim/bin/activate
python -m pip install pip --upgrade
python -m pip install neovim
```
- launch nvim, and you should see the automatic download and updates by lazy

## Neovim preparation and Installation for MacOSX
(To be completed)



## Neovim preparation and Installation for Windows 10 / Windows 11
Actions to be executed from administrator user:
1. Chocolatey package manager installation (see https://chocolatey.org/)
  - run the following from powershell admin
  ```
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  ```
  - close and reopen admin window
2. Winget package manager installation ( see https://learn.microsoft.com/en-us/windows/package-manager/winget/ )
  - install winget from microsoft store
3. From an administrator console, execute:
  ```
  winget install gnuwin32.tar (bsdtar, installed in c:\Windows\WinSxS\.. c:\cygwin64\bin...)
  winget install gnuwin32.findutils (grep)
  winget install Microsoft.WindowsTerminal (if not from winget, it can be installed from microsoft https://aka.ms/terminal https://github.com/microsoft/terminal#other-install-methods https://github.com/microsoft/terminal (go on releases on right side...))
  (for windows server 2022 -without winget- see later)

  choco install git less bat gzip ripgrep grep fd fzf far netcat curl wget procexp mingw make unzip (choco installs most of the tools in c:\ProgramData\chocolatey\bin)
  ```
  - nerdfonts are a nice to have extension. After font installation, they can be setup in Windows Terminal to be available for neovim interface. Go download nerdfonts https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip uncompress in a temporary folder. then select all the .ttf files and press right-click then install. Open MS terminal, press the top icon on the right of the "+", then choose Profile/Defaults on the left, then Appearance and in font face set Hack Nerd Font
  ```
  choco install python (for python development. (I experienced path issues when using python.org install, maybe due to Anaconda being on my system too)) 
  winget install StrawberryPerl.StrawberryPerl (or choco install StrawberryPerl - for perl development)
  cpanm -n Neovim::Ext (or cpan install Neovim::Ext) (for perl development)
  ```
  - A local node installation may be needed, for some language servers to be run. this requires the following:
  ```
  winget install OpenJS.NodeJS.LTS (or choco install nodejs-lts nodejs.commandline)
  npm install -g neovim (after closing and reopening admin window)
  npm install -g tree-sitter-cli  (this is needed to execute the :TSInstallFromGrammar <language> command within neovim)
  ```
  - And finally the neovim installation:
  ```
  winget install neovim (or choco install neovim)
  ``` 


## Neovim preparation and Installation for Windows Server 2022 (Datacenter Edition)

This operating system is similar to Windows 10/11 but I could not manage to have winget package installer working.
Luckily Chocolatey can install many packages.
  ``` 
  choco install less bat gzip ripgrep grep fd fzf far netcat curl wget procexp mingw make unzip git python strawberryperl neovim
  cpanm -n Neovim::Ext (or cpan install Neovim::Ext) (for perl development)
  ``` 
#### Microsoft Windows terminal
Installing Microsoft Windows Terminal (wt.exe) was a bit tricky: (as of may 2023 winget tool is not available on Windows server, and choco install microsoft-windows-terminal fails)

1. download Microsoft Windows Terminal from github release (on the right): download both preinstall kit and package for windows 10 version x64 architecture (windows11 version doesnt work). Unzip the preinstall kit.

2. Open powershell in administrator mode, and install the vc runtime from the preinstall kit before the package itself
  ``` 
  import-module appx -UseWindowsPowerShell
  Add-AppxPackage "C:\users\<your user>\downloads\Microsoft.WindowsTerminal_Win10_1.16.10261.0_8wekyb3d8bbwe.msixbundle_Windows10_PreinstallKit\Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.appx"
  Add-AppxPackage "C:\users\<your user>\downloads\Microsoft.WindowsTerminal_Win10_1.16.10261.0_8wekyb3d8bbwe.msixbundle"
  ```   
  
3. Now the tool should be available. You can invoke it with wt.exe

#### Node and related tools
On Windows server 2022 I could not install a functional version of npm thru choco, npm version is probably too old and neovim install fails. A workaround is to use yarn in place of npm
```   
choco install nodejs-lts yarn
yarn global add neovim
yarn global add tree-sitter-cli

```   

#### Other tools
For the other tools, nerdfonts etc... proceed using the same procedures listed for Windows 10/11. 

#### Neovim 
Neovim can be installed via choco
```   
choco install neovim
```   

### Neovim Kickstart Configuration for Windows (in non privileged user context)

```
  cd %HOMEPATH%	(typically c:\Users\<your-username>\)
  py -m venv venv_nvim	(for python development, we create a dedicated environment for nvim)
  .\venv_nvim\Scripts\activate 	(for python)
  py -m pip install pip --upgrade (for python, upgrade pip)
  py -m pip install neovim (for python, install neovim python package)
  mkdir %HOMEPATH%\AppData\Local\nvim\	(to avoid some path not found error)
  mkdir %HOMEPATH%\AppData\Local\Temp\nvim\ (to avoid some path not found error from lsp)
  (Exit from nvim if open)
  cd %HOMEPATH%\AppData\Local\
  ren nvim nvim_old
  mkdir nvim
  cd nvim
  git clone https://github.com/mgua/kickstart.nvim.git .
  (launch nvim)
```

# Additional configurations 
Please edit Python interpreter path to match the interpreter within the dedicated venv_nvim environment
- this edit is to be carried out in nvim/lua/custom/plugins/additional_keymaps.lua (windows) or in ~/.config/nvim/lua/custom/plugins/additional_keymaps.lua (linux)
- once done execute :checkhealth from nvim to see if there are other issues

# Treesitter and LSP language parser install
After configuration, from within nvim, we can proceed to install and activate additional language parsers. This can be done with 
  - :TSInstall <TAB>
    And choosing all the language we need. My preferences are:
  ```
  :TSInstall awk bash c cmake cpp dockerfile css html ini json lua make markdown mermaid perl php python regex sql vim yaml
  ```
  - Similar action is to be performed for LSP, whose config is managed via mason plugin. Some plugins like sqlls, intelphense, awk-language-server and others) require nodejs javascript modules to be managed via npm, therefore node installation is pre-required at the system level. 
  ```
  :MasonInstall awk-language-server bash-language-server ansible-language-server docker-compose-language-service dockerfile-language-server eslint-lsp html-lsp intelephense json-lsp lua-language-server marksman nginx-language-server perlnavigator pyright python-lsp-server sqlls vim-language-server
  ```


# Note: From now on the original documentation is untouched

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
* Running :checkhealth multiple issues appear related to html syntax  
  * answer is needed

### Windows Installation

Installation may require installing build tools, and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake, and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```

