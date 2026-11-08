# Neovim Configuration

A modular Neovim configuration that started from kickstart.nvim. It targets
**Neovim 0.12+**. Plugins are managed with [lazy.nvim](https://github.com/folke/lazy.nvim).
Language servers and formatters come from your OS package manager, not Mason.

## Requirements

| What | Why |
|---|---|
| Neovim **0.12** or newer | nvim-treesitter (`main` branch) and the built-in LSP setup need it |
| `git`, `curl`, `tar` | lazy.nvim and nvim-treesitter download plugins and parsers |
| `gcc` (or another C compiler), `make` | compiling treesitter parsers, telescope-fzf-native, CopilotChat |
| `tree-sitter` CLI **0.26.1** or newer | nvim-treesitter compiles parsers with it (install it from a package or release binary, not npm) |
| `ripgrep` | Telescope live grep |
| Node.js + npm | GitHub Copilot |
| `wl-clipboard` (Wayland) or `xclip` (X11) | system clipboard (`clipboard=unnamedplus`) |
| A [Nerd Font](https://www.nerdfonts.com/) | icons (`vim.g.have_nerd_font = true`) |

These language tools are optional. Each language server is only started if its program is installed:

| Language | Language server | Formatter (`<leader>lf`) |
|---|---|---|
| C / C++ | `clangd` | `clang-format` (uses the project's `.clang-format`, otherwise 4-space indents) |
| Lua | `lua-language-server` | lua-language-server |
| Nix | `nil` | `nixpkgs-fmt` |
| TOML | `taplo` | taplo |
| YAML | `yaml-language-server` | yaml-language-server |
| Python | `pyright` + `ruff` | ruff |
| Bash | `bash-language-server` (+ `shellcheck` for diagnostics) | `shfmt` |
| Rust | `rust-analyzer` | `rustfmt` |
| Markdown | – (rendered in the editor by render-markdown; lint: `markdownlint`, if installed) | – |

## Installation

### Arch Linux

```sh
sudo pacman -S --needed neovim git curl tar gcc make tree-sitter-cli ripgrep nodejs npm \
  wl-clipboard xclip lazygit \
  clang lua-language-server taplo-cli yaml-language-server pyright ruff \
  bash-language-server shellcheck shfmt rustup
rustup default stable
rustup component add rust-analyzer rustfmt
```

`clang` provides both `clangd` and `clang-format`. The Nix tools (`nil`, `nixpkgs-fmt`) are only in the AUR, so you only need them if you edit Nix files.

### Ubuntu (26.04 LTS)

Ubuntu's own `neovim` (0.11) and `tree-sitter-cli` (0.25) packages are too old, so install those two from upstream releases. Several language servers aren't packaged either; they come from npm, pipx, cargo or rustup.

```sh
# Base tools and the language tools that Ubuntu packages
sudo apt install git curl tar gcc make ripgrep nodejs npm wl-clipboard xclip pipx rustup \
  clangd clang-format shellcheck shfmt
mkdir -p ~/.local/bin

# Neovim 0.12 (official prebuilt release)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# tree-sitter CLI (prebuilt release binary)
curl -L https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz \
  | gunzip > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter

# lua-language-server (prebuilt release; pick the current version from its releases page)
LUALS=3.19.2
mkdir -p ~/.local/share/lua-language-server
curl -L https://github.com/LuaLS/lua-language-server/releases/download/$LUALS/lua-language-server-$LUALS-linux-x64.tar.gz \
  | tar -xz -C ~/.local/share/lua-language-server

# Language servers from npm / pipx
sudo npm install -g pyright yaml-language-server bash-language-server
pipx install ruff

# Rust toolchain, rust-analyzer, rustfmt, and taplo
rustup default stable
rustup component add rust-analyzer rustfmt
cargo install --locked taplo-cli
```

Then add the new directories to your `PATH`, for example in `~/.bashrc`:

```sh
export PATH="/opt/nvim-linux-x86_64/bin:$HOME/.local/bin:$HOME/.local/share/lua-language-server/bin:$HOME/.cargo/bin:$PATH"
```

For lazygit, see its [installation instructions](https://github.com/jesseduffield/lazygit#installation).

### Nix / NixOS (home-manager)

Add the tools to `home.packages`:

```nix
home.packages = with pkgs; [
  # General tools
  neovim                # text editor
  ripgrep               # fast grep, used by Telescope live grep
  nodejs                # JavaScript runtime, needed by Copilot
  gcc                   # C compiler, used to build treesitter parsers
  tree-sitter           # CLI that nvim-treesitter uses to compile parsers
  lazygit               # terminal UI for git

  # Language tools
  clang-tools           # clangd language server and clang-format formatter
  lua-language-server   # Lua language server (lua_ls), also formats Lua
  nil                   # Nix language server
  nixpkgs-fmt           # Nix formatter
  taplo                 # TOML language server and formatter
  yaml-language-server  # YAML language server (yamlls), also formats YAML
  pyright               # Python language server: types, completion, navigation
  ruff                  # Python linter and formatter (also runs as a language server)
  bash-language-server  # Bash language server (bashls)
  shellcheck            # shell script linter, used by bashls for diagnostics
  shfmt                 # shell script formatter
  rustc                 # Rust compiler
  cargo                 # Rust build tool and package manager
  rust-analyzer         # Rust language server
  rustfmt               # Rust formatter
];
```

Rebuild with `sudo nixos-rebuild switch --flake <your-flake>` (or `home-manager switch`).
To keep the config editable, link it with `config.lib.file.mkOutOfStoreSymlink` instead of copying it into the Nix store.

### Install the config

```sh
git clone git@github.com:eelko/nvim_config.git ~/.config/nvim
nvim
```

On first start:
- lazy.nvim installs all plugins.
- nvim-treesitter compiles the base parsers, and compiles others the first time you open a file of that type.
- Run `:Copilot setup` once to sign in to GitHub Copilot.

Use `:checkhealth` to find anything that's missing.

## Structure

```
init.lua                  -- entry point: loads core modules, sets up lazy.nvim and the main plugins
lua/user/core/
  globals.lua             -- leader key, nerd-font flag, WSL clipboard
  options.lua             -- editor options
  keymaps.lua             -- general key mappings
  autocmds.lua            -- autocommands (restore cursor, highlight on yank)
lua/user/plugins/         -- one file per larger plugin, imported by lazy.nvim
  completion.lua          -- nvim-cmp + LuaSnip
  formatter.lua           -- conform.nvim (formatting on demand only)
  lint.lua                -- nvim-lint (only runs linters that are installed)
  git.lua                 -- gitsigns, diffview, lazygit
  debugging.lua           -- nvim-dap + dap-ui (ARM gdb adapter)
  copilot.lua             -- Copilot + CopilotChat
  lua-ls.lua              -- lazydev (Neovim Lua API for lua_ls)
  tmux-navigator.lua      -- move between Neovim splits and tmux panes
```

Only `*.lua` files in `lua/user/plugins/` are loaded. Rename a file to `*.disabled` to turn it off (the alpha dashboard is disabled this way).
`lazy-lock.json` is not tracked, so every machine keeps its own plugin versions.

## Formatting

Formatting only happens when you ask for it: `<leader>lf` formats the buffer, or the selection in visual mode. Nothing formats on save.

## Key mappings

Leader is `<Space>`. Press `<leader>` and wait to see which-key's overview. `<leader>?` shows buffer-local mappings.

### Files and search
| Key | Action |
|---|---|
| `<leader>e` | toggle Oil file manager |
| `<leader>ff` / `<leader>fr` / `<leader>fb` | find files / recent files / buffers |
| `<leader>fw` / `<leader>f.` / `<leader>f/` | live grep / grep word under cursor / grep in open files |
| `<leader>fh` / `<leader>fk` / `<leader>fc` | help / keymaps / commands |
| `<leader>fd` / `<leader>f<CR>` | diagnostics / resume last picker |
| `<leader>b/` | fuzzy search in the current buffer |
| `<leader>fnf` / `<leader>fnw` | find files / grep in the Neovim config |

### Editing
| Key | Action |
|---|---|
| `<leader>/` | toggle comment (line, or selection in visual mode) |
| `<leader>ut` | toggle undo tree |
| `s` / `S` | flash jump / flash treesitter select |
| `<A-j>` / `<A-k>` | move line or selection down / up |
| `<leader>o` / `<leader>O` | insert empty line below / above |
| `af` `if` `ac` `ic` `aa` `ia` `ai` `ii` `al` `il` `a/` | treesitter text objects: function, class, parameter, if, loop, comment |
| `an` / `in` (visual) | grow / shrink selection to the surrounding syntax node (built-in) |

### Code navigation and LSP
| Key | Action |
|---|---|
| `gd` / `grr` / `gI` | definition / references / implementations (Telescope) |
| `gD` / `K` | declaration / hover |
| `grn` or `<leader>lr` | rename |
| `gra` or `<leader>la` | code action |
| `<leader>lf` | format buffer or selection |
| `<leader>ls` / `<leader>lS` / `<leader>lD` | document symbols / workspace symbols / type definition |
| `gs` | switch between C/C++ source and header (clangd) |
| `]f` `[f` `]F` `[F` | next / previous function start / end |
| `]C` `[C` · `]i` `[i` · `]l` `[l` · `]/` `[/` | next / previous class · if · loop · comment |
| `]d` / `[d` / `<C-w>d` | next / previous diagnostic / diagnostic float (built-in) |
| `<leader>xq` | diagnostics in the location list |

### Git
| Key | Action |
|---|---|
| `<leader>gg` / `<leader>gw` / `<leader>gv` | lazygit / project commits / file commits |
| `<leader>gdi` / `<leader>gdd` / `<leader>gdc` | diffview / diff against `develop` / close diffview |
| `]g` / `[g` | next / previous hunk |
| `<leader>gs` / `<leader>gr` / `<leader>gp` | stage-unstage / reset / preview hunk |
| `<leader>gS` / `<leader>gR` | stage / reset buffer |
| `<leader>gb` / `<leader>gB` / `<leader>gtd` | blame line / toggle line blame / show deleted lines inline |

### Buffers, windows and sessions
| Key | Action |
|---|---|
| `<S-h>` / `<S-l>`, `[b` / `]b` | previous / next buffer |
| `<leader>bd` / `<leader>bc` / `<leader>ba` | delete buffer / close buffer keeping the split / close all but current |
| `<leader>br` | cd to the git root of the current buffer |
| `\|` / `\` | split vertically / horizontally |
| `<C-h/j/k/l>` | move between splits (and tmux panes) |
| `<C-arrows>` | resize split |
| `<leader>wm` / `<leader>we` / `<leader>wc` | maximize toggle / equalize / close window |
| `<leader>wr` / `<leader>wl` / `<leader>wd` | restore session / restore last session / stop saving session |
| `[[` / `]]` | smooth scroll up / down |

### Debugging
| Key | Action |
|---|---|
| `<F5>` / `<leader>dc` | start / continue |
| `<F10>` / `<F11>` / `<F9>` | step over / into / out |
| `<leader>db` / `<leader>dB` | toggle breakpoint / conditional breakpoint |
| `<F7>` / `<leader>dt` | toggle debug UI |

The C debug configuration attaches to `arm-none-eabi-gdb` on `127.0.0.1:3333`, so that gdb has to be installed.

### Copilot and UI
| Key | Action |
|---|---|
| `<leader>ac` / `<leader>an` | open Copilot Chat / new chat session |
| `<leader>ae` `af` `ar` `ao` `at` `ad` (visual) | explain / fix / review / optimize / tests / docs |
| `<leader>tm` | toggle Markdown rendering (in Markdown files) |
| `<leader>uc` | pick a colorscheme |
| `<leader>un` / `<leader>um` / `<leader>ul` | tokyonight-night / catppuccin mocha / latte |
| `<leader>pl` | open Lazy |

## Adding a language

1. Install the language server (and formatter) with your package manager.
2. Add the server to the `servers` table in `init.lua`, using its [nvim-lspconfig name](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md).
3. Optionally add a formatter for the filetype in `lua/user/plugins/formatter.lua`.
