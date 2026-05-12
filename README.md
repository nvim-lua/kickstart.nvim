# nvim

Personal Neovim config, originally forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and broken into per-plugin files. Lives at `~/.config/nvim`.

## Layout

```
init.lua                    -- options, global keymaps, autocmds, lazy bootstrap
lua/custom/
├── zed-keymaps.lua         -- Zed-parity bindings + task spawners
├── health.lua              -- :checkhealth kickstart
└── plugins/*.lua           -- one file per plugin; auto-imported by lazy
lazy-lock.json              -- committed, pinned plugin versions
```

No build/test step. Changes take effect on `nvim` restart (or `:source %` / `:Lazy reload <plugin>`). Lua is formatted by `stylua` per `.stylua.toml` (2-space, single quotes, 160-col).

## Install

Requires Neovim stable or nightly, plus: `git`, `make`, a C compiler, `ripgrep`, a clipboard tool, and a [Nerd Font](https://www.nerdfonts.com/). Optional: `npm`, `go`, `python`, `java` for the respective LSPs.

```sh
git clone <your-fork> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
nvim
```

On first launch `lazy.nvim` installs every plugin under `lua/custom/plugins/`, and Mason installs the LSPs/formatters listed in `lsp.lua`. Run `:Lazy`, `:Mason`, `:checkhealth` to verify.

## Editor defaults (`init.lua`)

- Leader and localleader are **Space**.
- `relativenumber`, `cursorline`, `signcolumn=yes`, `scrolloff=8`, `splitright`/`splitbelow`.
- `spell` on (`en_us`); `undofile` on; `inccommand=split` for live substitution preview.
- `ignorecase` + `smartcase`; `timeoutlen=300`, `updatetime=250`.
- Per-filetype `colorcolumn`: python 80, lua 100, rust 100, go 120, java 120. Off everywhere else.
- Yank highlight on `TextYankPost`; clipboard synced to `unnamedplus` after UI ready.

## Plugins

| File | Plugin | Purpose |
| :--- | :--- | :--- |
| `lsp.lua` | `nvim-lspconfig` + Mason + `fidget.nvim` + `lazydev` | LSP for `clangd`, `gopls`, `pyright`, `ruff`, `lua_ls`; auto-installs `stylua`, `jdtls`, `google-java-format` |
| `cmp.lua` | `blink.cmp` | Completion (capabilities fed to LSP) |
| `conform.lua` | `conform.nvim` | Format on save (500ms timeout, LSP fallback; off for c/cpp/json/xml/html) |
| `lint.lua` | `nvim-lint` | Linting |
| `treesitter.lua` | `nvim-treesitter` (`main` branch) + textobjects | Highlight, indent, function/class/param motions |
| `treesitter-context.lua` | `nvim-treesitter-context` | Sticky context header |
| `telescope.lua` | `telescope.nvim` + `fzf-native` + `ui-select` | Fuzzy finder |
| `neo-tree.lua` | `neo-tree.nvim` | File tree (auto-opens on `nvim` / `nvim <dir>`) |
| `harpoon.lua` | `harpoon2` | Quick file marks |
| `gitsigns.lua` | `gitsigns.nvim` | Gutter signs, line blame (300ms), hunk actions |
| `lazygit.lua` | `lazygit.nvim` | Lazygit popup |
| `trouble.lua` | `trouble.nvim` | Diagnostics / refs / qflist panel |
| `todo.lua` | `todo-comments` | Highlight `TODO/FIX/HACK/...` |
| `toggleterm.lua` | `toggleterm.nvim` | Float / split terminals |
| `tmux.lua` | `smart-splits.nvim` | `<C-hjkl>` nav across nvim splits ↔ zellij panes |
| `mini.lua` | `mini.ai`, `mini.move`, `mini.notify`, `mini.starter`, `mini.statusline` | Misc utilities + statusline |
| `leap.lua` | `flash.nvim` | `s`/`S` motions, remote ops |
| `persistence.lua` | `persistence.nvim` | Per-cwd auto session |
| `which-key.lua` | `which-key.nvim` | Keybind popup |
| `copilot.lua` | `copilot.vim` | Inline suggestions (accept on `<M-Tab>`) |
| `copilot-chat.lua` | `CopilotChat.nvim` | In-editor chat |
| `render-markdown.lua` | `render-markdown.nvim` | Pretty markdown in buffer |
| `markdown-preview.lua` | `markdown-preview.nvim` | Browser preview |
| `gruvbox.lua` | gruvbox | Colorscheme |
| `neoscroll.lua` | `neoscroll.nvim` | Smooth scrolling |
| `illuminate.lua` | `vim-illuminate` | Highlight word under cursor |
| `indent_line.lua` | `indent-blankline` | Indent guides |
| `autopairs.lua` | `nvim-autopairs` | Bracket pairs |
| `nvim-surround.lua` | `nvim-surround` | Surround motions |
| `dressing.lua` | `dressing.nvim` | Better `vim.ui` prompts |
| `sleuth.lua` | `vim-sleuth` | Auto-detect indent |
| `java.lua` | `nvim-jdtls` | Java LSP wrapper |
| `debug.lua` | `nvim-dap` + UI | Debugger |

## Keymaps

### Movement & editing (`init.lua` / `zed-keymaps.lua`)
| Key | Mode | Action |
| :--- | :--- | :--- |
| `;` | n | `:` (command mode) |
| `<Esc>` | n | Clear search highlight |
| `oo` / `OO` | n | Open blank line below/above without entering insert |
| `<leader>p` | x | Paste without clobbering register |
| `<A-j>` / `<A-k>` | n/v | Move line/selection down/up |
| `<C-h/j/k/l>` | i | Arrow keys in insert |
| `<C-h/l/b/f/k/j>` | c | Word/char nav in command line |
| `<C-w>` | i | Delete previous word |
| `s` / `S` / `r` / `R` | n/x/o | flash.nvim jump / treesitter / remote |

### Windows, buffers, tasks
| Key | Action |
| :--- | :--- |
| `<C-h/j/k/l>` | Focus split — falls through to zellij pane |
| `<A-1>`..`<A-9>` | Jump to buffer slot 1..9 (`vim.t.bufs[i]`) |
| `<leader>x` | Close current buffer |
| `<leader>t` / `<leader>T` | Floating / horizontal toggleterm |
| `<C-\>` | Open mapping for toggleterm |
| `<leader>gh` | `gh dash` in floating pane |
| `<leader>kk` | `k9s` |
| `<leader>bb` | bruno tests |
| `<leader>uu` / `<leader>dd` | `make up` / `make down` in `restopay/` |
| `<leader>aa` | Refresh Athenz cert + AWS creds for `external-factory` |

### Finder (`<leader>f…`)
| Key | Action |
| :--- | :--- |
| `<leader>ff` | Files |
| `<leader>fg` | Live grep |
| `<leader>fw` | Grep current word |
| `<leader>fd` | Diagnostics |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fs` | Telescope builtins |
| `<leader>fr` | Resume last picker |
| `<leader>f.` | Recent files |
| `<leader>fc` | Commands |
| `<leader>fe` | Workspace symbols |
| `<leader><leader>` | Buffers |
| `<leader>/` | Fuzzy find in current buffer |
| `<leader>s/` | Live grep in open buffers |
| `<leader>sn` | Find files in nvim config |

### LSP (set on `LspAttach`, plus zed-parity)
| Key | Action |
| :--- | :--- |
| `gd` / `gr` / `gI` | Definitions / refs / implementations (telescope) |
| `gi` | Implementations (lowercase zed-style) |
| `gD` | Declaration |
| `<leader>D` | Type definition |
| `<leader>ds` / `<leader>ws` | Document / workspace symbols |
| `<leader>rn` or `F2` | Rename |
| `<leader>ca` or `<leader>.` | Code action |
| `<leader>th` | Toggle inlay hints (on by default for Go) |
| `<leader>q` | Diagnostics → loclist |
| `<leader>f` | Format buffer (conform) |

### Git
| Key | Action |
| :--- | :--- |
| `]c` / `[c` | Next / prev hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (works in visual) |
| `<leader>hS` / `<leader>hR` | Stage / reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame current line |
| `<leader>hd` / `<leader>hD` | Diff vs index / last commit |
| `<leader>tb` / `<leader>tD` | Toggle inline blame / deleted markers |
| `gb` | Full-buffer blame |

### Harpoon
| Key | Action |
| :--- | :--- |
| `<leader>ha` | Add current file |
| `<leader>hh` | Toggle harpoon menu |
| `<leader>1`..`<leader>4` | Jump to slot 1..4 |
| `[h` / `]h` | Prev / next entry |

### Trouble (`<leader>x…`)
| Key | Action |
| :--- | :--- |
| `<leader>xx` | Workspace diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xs` | Symbols |
| `<leader>xr` | LSP refs/defs (right) |
| `<leader>xl` / `<leader>xq` | Loclist / quickfix |

### Neo-tree
| Key | Action |
| :--- | :--- |
| `\` or `<leader>e` | Reveal file in tree |
| (inside tree) `h` / `l` / `<tab>` | Collapse / expand+open / smart-toggle |
| (inside tree) `T` | Trash file (via `trash` CLI) |

### Treesitter textobjects
`af`/`if` function, `ac`/`ic` class, `aa`/`ia` parameter, `al`/`il` loop; `]m`/`[m`/`]M`/`[M` move between functions.

### Copilot / chat
| Key | Action |
| :--- | :--- |
| `<M-Tab>` (insert) | Accept Copilot suggestion |
| `<leader>cc` / `<leader>ce` / `<leader>cf` / `<leader>cr` / `<leader>ct` / `<leader>cm` | Chat / explain / fix / review / tests / commit-msg |

### Sessions (persistence.nvim)
| Key | Action |
| :--- | :--- |
| `<leader>qs` | Load session for cwd |
| `<leader>ql` | Load last session |
| `<leader>qd` | Stop saving current session |

## LSP & formatting notes

- `gopls` uses `-tags=integration`, `gofumpt`, `staticcheck`, full inlay hints; `useany`/`unusedparams` on, `shadow` off.
- Go imports run as a `source.organizeImports` code action on `BufWritePre` for `*.go`.
- `pyright` lint is suppressed and its organize-imports disabled; `ruff` handles lint + organize + format. `ruff`'s hover is disabled — `pyright` provides hover.
- `lua_ls`: `callSnippet = 'Replace'`; `lazydev` loads `vim.uv` types.
- Per-ft formatters: `stylua` (lua), `ruff_organize_imports` + `ruff_format` (python), `google-java-format` (java), `terraform_fmt`, `prettier`/`xmlformatter` (xml), `prettierd`/`prettier` (js). Format-on-save off for `c`/`cpp`/`json`/`xml`/`html`.

## Adding a plugin

Drop a new file in `lua/custom/plugins/` returning a lazy spec. No central manifest. After edits, run `:Lazy sync` (or restart) and commit `lazy-lock.json` alongside the spec.

## FAQ

- **Where do LSP keymaps live?** In the `LspAttach` autocmd in `lsp.lua`. Add new buffer-local LSP bindings there, not globally.
- **Why doesn't `<C-h/j/k/l>` move splits in some configs?** They're owned by `smart-splits.nvim`; at a split edge they forward to the zellij pane (`multiplexer_integration = 'zellij'`).
- **Uninstall:** see [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling).
- **Run alongside another config:** `NVIM_APPNAME=nvim-other nvim`.
