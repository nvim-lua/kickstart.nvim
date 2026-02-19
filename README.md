# nvim

Personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
Single-file, fully documented, no magic.

---

## Requirements

| Dependency | Purpose |
|---|---|
| Neovim `>= 0.10` (latest stable recommended) | Runtime |
| `git`, `make`, `gcc` / `clang` | Plugin builds |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Live grep in Telescope |
| [fd-find](https://github.com/sharkdp/fd) | File finder |
| `claude` CLI (Claude Code) | AI agent ([99](#ai-agent--99)) |
| Clipboard tool (`xclip`, `xsel`, `win32yank`) | System clipboard sync |

Install Neovim on WSL (Ubuntu/Debian):

```sh
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```

---

## Installation

```sh
# Back up any existing config first
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repo
git clone https://github.com/0xWheatyz/kickstart.nvim.git ~/.config/nvim

# Launch — Lazy will bootstrap and install all plugins automatically
nvim
```

Run `:Lazy` to check plugin status. Run `:checkhealth` if anything looks wrong.

---

## Structure

Everything lives in a single file:

```
~/.config/nvim/
├── init.lua          ← entire config (options, keymaps, plugins)
└── lua/
    ├── custom/plugins/   ← drop extra plugin files here (optional)
    └── kickstart/plugins/    ← optional bundled extras (debug, neo-tree, etc.)
```

The config is intentionally kept in one file so every line is readable
top-to-bottom without jumping between modules.

---

## Plugins

| Plugin | Purpose |
|---|---|
| `folke/lazy.nvim` | Plugin manager |
| `NMAC427/guess-indent.nvim` | Auto-detect indentation |
| `lewis6991/gitsigns.nvim` | Git gutter signs |
| `folke/which-key.nvim` | Keymap hints popup |
| `nvim-telescope/telescope.nvim` | Fuzzy finder |
| `neovim/nvim-lspconfig` + `mason-org/mason.nvim` | LSP + auto-install |
| `stevearc/conform.nvim` | Formatting on save |
| `saghen/blink.cmp` + `L3MON4D3/LuaSnip` | Completion + snippets |
| `folke/tokyonight.nvim` | Colorscheme (tokyonight-night) |
| `folke/todo-comments.nvim` | Highlight TODO/FIXME/NOTE |
| `nvim-mini/mini.nvim` | Text objects, surround, statusline |
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting |
| `ThePrimeagen/99` | AI agent |

---

## Keymaps

`<leader>` is `<Space>`.

### General

| Key | Action |
|---|---|
| `<Esc>` | Clear search highlight |
| `<C-h/j/k/l>` | Move between splits |
| `<leader>q` | Open diagnostic quickfix list |
| `<leader>f` | Format buffer |
| `<leader>th` | Toggle inlay hints (when LSP supports it) |

### Telescope (Search)

| Key | Action |
|---|---|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Grep word under cursor (or selection) |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>sc` | Search commands |
| `<leader>sn` | Search Neovim config files |
| `<leader>/` | Fuzzy search current buffer |
| `<leader>s/` | Live grep in open files |
| `<leader><leader>` | Open buffer list |

### LSP (active when a language server is attached)

| Key | Action |
|---|---|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grD` | Go to declaration |
| `grd` | Go to definition |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |

### AI Agent (99)

| Key | Mode | Action |
|---|---|---|
| `<leader>9v` | visual | Send selection as AI request |
| `<leader>9s` | normal | Open search / ask AI |
| `<leader>9x` | normal | Cancel all in-flight requests |

In the 99 prompt:
- `@<filename>` — fuzzy-attach a project file as context
- `#<rulename>` — autocomplete and attach a rule/skill file

---

## AI Agent — 99

[ThePrimeagen/99](https://github.com/ThePrimeagen/99) is a Neovim-native AI
agent that delegates to a CLI backend. This config uses **Claude Code**
(`claude` CLI) as the provider.

### Prerequisites

Claude Code must be installed and authenticated:

```sh
npm install -g @anthropic-ai/claude-code
claude login
```

### How it works

1. Open any file and make a visual selection (or just use `<leader>9s` for a
   free-form prompt).
2. Press `<leader>9v` (visual) or `<leader>9s` (normal) to open the prompt.
3. Describe what you want. Use `@file` to attach context, `#rule` to attach a
   skill/rule doc.
4. 99 streams the response back into the buffer as virtual text, then applies
   replacements inline.
5. Press `<leader>9x` at any time to abort.

### Debugging

```vim
:lua require("99").view_logs()
```

Navigate log history with `_99.prev_request_logs()` / `_99.next_request_logs()`.

### AGENT.md (optional)

Drop an `AGENT.md` file in any directory (or project root) to give 99
project-specific context. It is automatically injected into every request
made from files under that directory.

```
project-root/
└── AGENT.md    ← describes conventions, architecture, rules
```

### Skill files (optional)

Custom rule files enable `#<skill>` autocompletion in the prompt. Each skill
is a folder with a `SKILL.md` inside:

```
~/.config/nvim/skills/
└── my-rule/
    └── SKILL.md
```

Point 99 at them by adding to `completion.custom_rules` in the setup call
inside `init.lua`.

---

## Maintaining the Config

All changes happen in `~/.config/nvim/init.lua`. The file is organized in this order:

1. **Options** — `vim.o.*` / `vim.opt.*` settings
2. **Keymaps** — `vim.keymap.set(...)` for built-in bindings
3. **Autocommands** — `vim.api.nvim_create_autocmd(...)`
4. **Plugin specs** — passed to `require('lazy').setup({...})`

### Adding a plugin

Add an entry anywhere inside the `require('lazy').setup({ ... })` table:

```lua
{ 'author/plugin-name', opts = {} },
```

For plugins that need configuration:

```lua
{
  'author/plugin-name',
  event = 'VimEnter',   -- optional: defer loading
  config = function()
    require('plugin-name').setup {
      -- options here
    }
    vim.keymap.set('n', '<leader>x', ...)
  end,
},
```

Then run `:Lazy sync` (or restart Neovim) to install.

### Updating plugins

```vim
:Lazy update
```

This updates all plugins and refreshes `lazy-lock.json`.

### Adding a language server

Inside the `servers` table in the `nvim-lspconfig` config block:

```lua
local servers = {
  gopls = {},
  pyright = {},
  ts_ls = {},
}
```

Mason will auto-install it. Run `:Mason` to check status.

### Adding a formatter

Inside the `conform.nvim` `opts.formatters_by_ft` table:

```lua
formatters_by_ft = {
  lua = { 'stylua' },
  python = { 'black' },
  javascript = { 'prettierd', 'prettier', stop_after_first = true },
},
```

Make sure the formatter binary is installed via Mason or your system package
manager.

### Switching the colorscheme

Replace the `folke/tokyonight.nvim` plugin entry with any other colorscheme,
and update `vim.cmd.colorscheme 'theme-name'` in its `config` function.

### Checking health

```vim
:checkhealth
```

Covers LSP, Treesitter, Telescope, and plugin-specific diagnostics.

---

## Optional Extras

Uncomment any of these lines near the bottom of `init.lua` to enable bundled
extras:

```lua
require 'kickstart.plugins.debug',      -- DAP debugger UI
require 'kickstart.plugins.indent_line', -- indent guides
require 'kickstart.plugins.lint',       -- async linting
require 'kickstart.plugins.autopairs',  -- bracket auto-close
require 'kickstart.plugins.neo-tree',   -- file tree
require 'kickstart.plugins.gitsigns',   -- extra git keymaps
```

Drop additional plugin files under `lua/custom/plugins/` and uncomment:

```lua
{ import = 'custom.plugins' },
```

at the bottom of the lazy setup call.
