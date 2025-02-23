# Customized Neovim Configuration

This Neovim configuration is based on kickstart.nvim and has been customized with additional features and language support.

## Features

### Language Support

#### Go Development
- Full LSP support via `gopls`
- Advanced formatting with `gofumpt`
- Import management with `goimports`
- Linting with `golangci-lint`
- Debugging support with Delve

#### Zig Development
- LSP support via `zls`
- Auto-formatting on save
- Syntax highlighting

#### C Development
- LSP support via `clangd`
- Code formatting with `clang-format`
- Debugging with `codelldb`
- Enhanced features through `clangd_extensions.nvim`:
  - Inlay hints
  - AST viewer
  - Header/source switching
  - Symbol info

#### Python Development
- LSP support via `pyright`
- Code formatting with `black`
- Linting with `ruff`
- Debugging with `debugpy`
- Virtual environment support
- Auto-detection of Python path

### Debug Adapter Protocol (DAP)
Integrated debugging support with a consistent interface across languages:

#### Keybindings
- `<leader>pb` - Toggle breakpoint
- `<leader>pc` - Continue debugging
- `<leader>pn` - Step over (Next)
- `<leader>pi` - Step into
- `<leader>po` - Step out
- `<leader>pr` - Debug REPL
- `<leader>pl` - Run last debug session
- `<leader>px` - Toggle debug UI

#### Debug UI Features
- Left sidebar:
  - Scopes
  - Breakpoints
  - Call stack
  - Watches
- Bottom panel:
  - REPL
  - Console output

### Additional Plugins and Features

#### Snacks.nvim Integration
- Smooth scrolling
- Enhanced terminal support
- Custom dashboard
- Git integration
- Improved display features

#### Profiling Support
Integrated profiling for multiple languages using `<leader>mp`:

##### Go Profiling
- Uses `pprof` for CPU and memory profiling
- Runs benchmarks and generates profile data
- Opens interactive web UI for visualization
- Shows both CPU and memory profiles
- Supports flame graphs and call graphs

##### Python Profiling
- Uses `py-spy` for sampling profiler
- Non-intrusive profiling (doesn't modify code)
- Generates SVG flame graphs
- Shows CPU usage and call stacks
- Works with running processes

##### C/C++ Profiling
- Uses `perf` for system-wide profiling
- Shows CPU usage and call graphs
- Supports hardware performance counters
- Low-overhead profiling
- Kernel and userspace profiling

For Zig, profiling is still in development in the language tooling. Once stable profiling tools are available, they will be integrated.

## Installation Guide

### Core Dependencies

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y git curl unzip ripgrep fd-find make gcc g++ xclip

# Arch Linux
sudo pacman -S git curl unzip ripgrep fd make gcc xclip
```

### Language-Specific Installation

#### Go Development Tools
```bash
# Install Go
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

# Install Go tools (will be handled by Mason, but can be installed manually)
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/google/pprof@latest
```

#### Zig Development Tools
```bash
# Install Zig (latest version)
wget https://ziglang.org/download/0.11.0/zig-linux-x86_64-0.11.0.tar.xz
sudo tar -C /usr/local -xf zig-linux-x86_64-0.11.0.tar.xz
echo 'export PATH=$PATH:/usr/local/zig-linux-x86_64-0.11.0' >> ~/.bashrc
source ~/.bashrc

# ZLS will be installed by Mason
```

#### C/C++ Development Tools
```bash
# Ubuntu/Debian
sudo apt install -y clang clangd clang-format lldb linux-perf

# Arch Linux
sudo pacman -S clang lldb perf
```

#### Python Development Tools
```bash
# Install Python and pip
sudo apt install -y python3 python3-pip python3-venv

# Install global tools (will be handled by Mason, but can be installed manually)
pip3 install --user black ruff debugpy py-spy

# For each project, it's recommended to use a virtual environment:
python3 -m venv .venv
source .venv/bin/activate
pip install black ruff debugpy py-spy
```

### Neovim Installation

#### Install Latest Neovim
```bash
# Ubuntu/Debian
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

# Arch Linux
sudo pacman -S neovim
```

#### Install Configuration
```bash
# Backup existing config if needed
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# Clone this configuration
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
```

### Post-Installation

1. Start Neovim:
   ```bash
   nvim
   ```
   This will automatically:
   - Install the plugin manager (Lazy)
   - Install all plugins
   - Install LSP servers and tools via Mason

2. Verify installation:
   ```
   :checkhealth
   ```

3. Install language servers and tools:
   ```
   :Mason
   ```
   Use `i` to install any missing tools.

### Troubleshooting

#### Common Issues

1. **LSP not working**
   - Check if the language server is installed: `:Mason`
   - Verify server status: `:LspInfo`
   - Install language server manually if needed

2. **Debugger not working**
   - Ensure debugger is installed: `:Mason`
   - Check if language tools are in PATH
   - For Python, make sure you're in the correct virtual environment

3. **Profiler issues**
   - For Go: Ensure `pprof` is installed and `go` is in PATH
   - For Python: Check `py-spy` installation and permissions
   - For C/C++: `perf` might need root permissions: `sudo sysctl -w kernel.perf_event_paranoid=1`

## Usage

### Go Development
1. Open a Go file
2. LSP features will work automatically
3. Use `gofumpt` for enhanced formatting
4. Debug your Go programs with Delve

### Zig Development
1. Open a Zig file
2. LSP features and formatting will work automatically

### C Development
1. Open a C file
2. LSP features will work automatically
3. For debugging:
   - Build your program with debug symbols (`gcc -g`)
   - Set breakpoints and start debugging
   - Use the debug UI to inspect variables and control execution

### Python Development
1. Open a Python file
2. LSP features will work automatically
3. Use `black` for code formatting
4. For debugging:
   - Set breakpoints with `<leader>pb`
   - Start debugging with `<leader>pc`
   - Python path will be auto-detected from virtual environments
   - Use the debug UI to inspect variables and control execution

## Customization
- LSP settings can be modified in `lua/plugins/nvim-lspconfig.lua`
- Debug configurations are in `lua/plugins/coding.lua`
- Additional language support can be added through Mason and appropriate LSP configurations

## Contributing
Feel free to submit issues and enhancement requests!

## Introduction

A starting point for Neovim that is:

* Small
* Single-file
* Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

> **NOTE**
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> **NOTE**
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

> **NOTE**
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommended to track it in version control](https://lazy.folke.io/usage#lockfile).

#### Clone kickstart.nvim
> **NOTE**
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
the current plugin status. Hit `q` to close the window.

#### Read The Friendly Documentation

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

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
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Discussions on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#Install-Kickstart) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>
