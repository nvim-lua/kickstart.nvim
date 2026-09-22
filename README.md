# Neovim configuration

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim)
for plugins and [Mason](https://github.com/mason-org/mason.nvim) for language
servers.

## Requirements

### Core

- Neovim 0.12 or newer
- Git
- `curl`, `tar`, `gzip`, and `unzip`
- A C compiler
- `tree-sitter-cli` 0.26.1 or newer
- Node.js and npm (used by Mason to install Pyright and the TypeScript server)
- `ripgrep` (used by Telescope's live grep)
- `make` (builds Telescope's native fuzzy finder)

After the LSP configuration loads, Mason automatically installs these configured
language servers:

- `clangd`
- `lua-language-server`
- `pyright`
- `rust-analyzer`
- `typescript-language-server`

Mason installs the servers, but it does not install the corresponding language
runtimes or project toolchains. Install Python, a C/C++ toolchain, Node.js, and
Rust as needed for the projects edited on the machine.

### Formatters

The configuration uses these external formatters when available:

- `stylua` for Lua
- `clang-format` for C and C++
- `rustfmt` for Rust

### Optional integrations

- `openai-codex` enables the Sidekick Codex terminal (`<leader>aa`).
- `zellij` enables persistent Sidekick terminal sessions.
- A system clipboard provider is needed for local clipboard synchronization:
  `wl-clipboard` on Wayland, `xclip` on X11, or the platform equivalent.
- A Nerd Font is expected by the configured UI icons.

Remote sessions use OSC 52 for clipboard writes. Recent Zellij versions block
OSC 52 clipboard reads by default, so remote paste should use the terminal's
normal paste action.

## Arch Linux setup

Install the complete toolset with:

```sh
sudo pacman -S --needed \
  neovim git curl tar gzip unzip make gcc ripgrep \
  nodejs npm tree-sitter-cli \
  python clang rust stylua \
  zellij wl-clipboard openai-codex
```

Remove language toolchains or optional integrations from that command when they
are not needed.

## First launch

From the root of the parent dotfiles repository, initialize its submodules and
then start Neovim:

```sh
git submodule update --init --recursive
nvim
```

Lazy installs the plugins. Opening a supported source file loads the LSP
configuration and starts Mason's language-server installation. After installation
completes, run these checks inside Neovim:

```vim
:Lazy sync
:Mason
:checkhealth nvim-treesitter
:checkhealth vim.lsp
:ConformInfo
```

`tree-sitter-cli` is a system dependency rather than an automatically managed
language server. If parser compilation reports that `tree-sitter` cannot be
found, install the CLI package and rerun `:TSUpdate`.
