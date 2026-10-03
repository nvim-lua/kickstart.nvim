# Neovim Configuration

Personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), with additional support for SAP CDS development and Git workflows.

## Requirements

- Neovim 0.12 or newer
- `git`
- A C compiler and `make` for native plugin builds and the optional Telescope FZF extension
- `ripgrep` and `fd` for Telescope searches
- A clipboard provider such as `xclip`, `xsel`, or `wl-clipboard`
- `cds-lsp` available on `PATH` for CDS language-server features

Optional:

- A [Nerd Font](https://www.nerdfonts.com/) for icons. Set `vim.g.have_nerd_font = true` in `init.lua` when one is installed.
- `tree-sitter` CLI if a local parser build is required

## Installation

Back up an existing Neovim configuration before installing. Neovim normally loads this repository from:

- macOS/Linux: `~/.config/nvim`
- Windows: `%LOCALAPPDATA%\\nvim`

Clone the repository into the appropriate directory. For macOS/Linux:

```sh
git clone <repository-url> "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

Start Neovim:

```sh
nvim
```

Plugins are installed and managed with Neovim's built-in `vim.pack`. The first launch installs the configured plugins. The lockfile is tracked in `nvim-pack-lock.json`.

Inspect plugin state without fetching updates:

```vim
:lua vim.pack.update(nil, { offline = true })
```

Fetch and review plugin updates:

```vim
:lua vim.pack.update()
```

Write the proposed update to apply it, or quit to cancel.

## SAP CDS Support

The configuration recognizes these file extensions:

- `.cds` as `cds`
- `.cdl` as `cdl`
- `.hdbcds` as `hdbcds`

For those filetypes it provides:

- Tree-sitter syntax highlighting using `cap-js-community/tree-sitter-cds`
- Tracked highlights, injections, locals, and tags queries under `lua/custom/plugins/queries/cds`
- `cds-lsp` through Neovim's native LSP configuration
- `//` comment formatting

Open a CDS file and check `:LspInfo` if the language server does not attach. The `cds-lsp` executable must be installed separately and resolvable from Neovim's `PATH`.

The CDS parser and queries are already part of this repository. No manual query download is required.

## Included Features

- Built-in `vim.pack` plugin management
- Mason-managed LSP servers for Lua, Go, Python, TypeScript, JSON, Java, Rust, C/C++, and Stylua
- LSP completion with `blink.cmp` and `LuaSnip`
- Tree-sitter parsing with automatic parser installation
- Telescope file, buffer, Git, diagnostic, LSP, and text search pickers
- Neo-tree with dotfiles visible and Git-ignored files hidden
- Catppuccin Latte/Mocha colorscheme selected from the current background
- Git signs, hunk actions, inline diffs, and blame through Gitsigns
- Fugitive and LazyGit integrations
- GitHub Copilot
- Conform formatting support

## Key Bindings

The leader key is `<Space>`.

| Key | Action |
| --- | --- |
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sn` | Search Neovim configuration files |
| `<leader><leader>` | Find open buffers |
| `<leader>sd` | Search diagnostics |
| `<leader>gc` | Search Git commits |
| `\\` | Reveal the current file in Neo-tree |
| `<leader>gg` | Open LazyGit |
| `<leader>gvd` | Open a Fugitive diff split |
| `<leader>cf` | Format the current buffer |
| `<leader>q` | Open the diagnostics quickfix list |
| `<leader>yrp` | Yank the current file's relative path |
| `<leader>yap` | Yank the current file's absolute path |
| `]c` / `[c` | Next/previous Git change |
| `<leader>hp` | Preview the current Git hunk |
| `<leader>hb` | Show full blame for the current line |
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Move between splits |

Use `:WhichKey` or `<leader>sk` to discover additional mappings.

## Repository Layout

```text
init.lua                         Core options and module loading
lua/kickstart/plugins/           General editing, UI, LSP, search, and Git setup
lua/custom/plugins/              Personal integrations
lua/custom/plugins/cds.lua       CDS filetypes, parser, queries, and cds-lsp
lua/custom/plugins/queries/cds/  CDS Tree-sitter query files
nvim-pack-lock.json              Plugin lockfile
```

Most customization belongs in `lua/custom/plugins/`. Plugin modules in that directory are loaded explicitly from `init.lua`; `lua/custom/plugins/init.lua` also provides a directory-based loader when desired.

## Troubleshooting

- Run `:checkhealth` for general Neovim diagnostics.
- Run `:Mason` to inspect or install language servers and formatters.
- Run `:LspInfo` to inspect attached language servers.
- Run `:TSInstallInfo` to inspect Tree-sitter parsers.
- Run `:messages` after a plugin installation or build failure.
- Confirm external tools with `:echo executable('cds-lsp')` and `:echo executable('make')`.
