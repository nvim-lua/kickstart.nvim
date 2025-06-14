# Neorg Keybindings Reference

All Neorg keybindings are namespaced under `<Leader>n` to avoid conflicts with other plugins. These bindings are only active in `.norg` files.

## 🚀 Getting Started

To check your Neorg setup, run this command in Neovim:

```vim
:lua require('custom.utils.neorg_setup_check').check()
```

To create your first Neorg file:

```vim
:e myfile.norg
```

To access your notes index:

```vim
:Neorg workspace notes
```

## Navigation & Workspace Management

| Keybinding    | Description                  |
| ------------- | ---------------------------- |
| `<Leader>nw`  | Open workspace selector      |
| `<Leader>nn`  | Switch to notes workspace    |
| `<Leader>nwp` | Switch to personal workspace |
| `<Leader>nl`  | Return to last workspace     |

## Journal

| Keybinding    | Description                 |
| ------------- | --------------------------- |
| `<Leader>nj`  | Open today's journal        |
| `<Leader>nyt` | Open yesterday's journal    |
| `<Leader>ntm` | Open tomorrow's journal     |
| `<Leader>nwd` | Go to day view in journal   |
| `<Leader>nwm` | Go to month view in journal |

## Document Structure

| Keybinding    | Description                |
| ------------- | -------------------------- |
| `<Leader>ntt` | Generate table of contents |
| `<Leader>ni`  | Inject metadata            |
| `<Leader>nm`  | Update metadata            |
| `<Leader>nc`  | Toggle concealer           |

## Content Creation

| Keybinding    | Description |
| ------------- | ----------- |
| `<Leader>nil` | Insert link |
| `<Leader>nid` | Insert date |

## Export

| Keybinding    | Description        |
| ------------- | ------------------ |
| `<Leader>nem` | Export to Markdown |

## Advanced List Manipulation

| Keybinding   | Description                     |
| ------------ | ------------------------------- |
| `<Leader>nu` | Iterate next (cycle list types) |
| `<Leader>np` | Iterate previous                |

## Default Keybindings

Additionally, Neorg has many default keybindings that are active in `.norg` files:

### Navigation

| Keybinding | Description                  |
| ---------- | ---------------------------- |
| `<CR>`     | Follow link under cursor     |
| `<M-k>`    | Follow link up               |
| `<M-j>`    | Follow link down             |
| `<M-h>`    | Follow link previous         |
| `<M-l>`    | Follow link next             |
| `gO`       | Navigate to previous heading |
| `gI`       | Navigate to next heading     |

### Lists & Tasks

| Keybinding | Description                            |
| ---------- | -------------------------------------- |
| `<M-CR>`   | Toggle task status                     |
| `<M-v>`    | Toggle list type                       |
| `<Tab>`    | Indent current line (in insert mode)   |
| `<S-Tab>`  | Unindent current line (in insert mode) |

### Folding (when folding is enabled)

| Keybinding | Description              |
| ---------- | ------------------------ |
| `za`       | Toggle fold under cursor |
| `zR`       | Open all folds           |
| `zM`       | Close all folds          |

### Text Objects

| Keybinding | Description    |
| ---------- | -------------- |
| `ah`       | Around heading |
| `ih`       | Inside heading |
| `al`       | Around list    |
| `il`       | Inside list    |

### Presenter Mode

| Keybinding | Description         |
| ---------- | ------------------- |
| `j`/`k`    | Next/previous slide |
| `q`        | Exit presenter      |

## Command Reference

| Command                   | Description                    |
| ------------------------- | ------------------------------ |
| `:Neorg keybind all`      | Show all available keybindings |
| `:Neorg index`            | Go to workspace index file     |
| `:Neorg return`           | Return to previous location    |
| `:Neorg toggle-concealer` | Toggle concealer               |
