# Neovim Keybindings Reference

This document provides a comprehensive reference for all keybindings in your Neovim configuration.

## Table of Contents

- [General Keybindings](#general-keybindings)
- [Navigation](#navigation)
- [Editing](#editing)
- [UI & Terminal](#ui--terminal)
- [Plugin Keybindings](#plugin-keybindings)
  - [Telescope](#telescope)
  - [Bufferline](#bufferline)
  - [Harpoon](#harpoon)
  - [Git](#git)
  - [Copilot](#copilot)
  - [Neorg](#neorg)
  - [LeetCode](#leetcode)

## General Keybindings

| Keybinding  | Mode   | Description             |
| ----------- | ------ | ----------------------- |
| `<leader>w` | Normal | Save file               |
| `<leader>q` | Normal | Quit                    |
| `<leader>Q` | Normal | Force quit all          |
| `<leader>W` | Normal | Save and quit           |
| `<leader>/` | Normal | Clear search highlights |
| `<Esc>`     | Normal | Clear highlights        |

## Navigation

### Window Navigation

| Keybinding | Mode   | Description                |
| ---------- | ------ | -------------------------- |
| `<C-h>`    | Normal | Move focus to left window  |
| `<C-j>`    | Normal | Move focus to down window  |
| `<C-k>`    | Normal | Move focus to up window    |
| `<C-l>`    | Normal | Move focus to right window |

### Window Management

| Keybinding   | Mode   | Description               |
| ------------ | ------ | ------------------------- |
| `<leader>wv` | Normal | Split window vertically   |
| `<leader>ws` | Normal | Split window horizontally |
| `<leader>wq` | Normal | Close current window      |
| `<leader>wo` | Normal | Close other windows       |
| `<M-Up>`     | Normal | Increase window height    |
| `<M-Down>`   | Normal | Decrease window height    |
| `<M-Left>`   | Normal | Decrease window width     |
| `<M-Right>`  | Normal | Increase window width     |

### Tab Management

| Keybinding   | Mode   | Description       |
| ------------ | ------ | ----------------- |
| `<leader>tn` | Normal | New tab           |
| `<leader>to` | Normal | New tab with file |
| `<leader>tc` | Normal | Close tab         |
| `<C-PgDn>`   | Normal | Next tab          |
| `<C-PgUp>`   | Normal | Previous tab      |

### Buffer Navigation

| Keybinding         | Mode   | Description     |
| ------------------ | ------ | --------------- |
| `<leader><leader>` | Normal | Find buffers    |
| `<leader>bd`       | Normal | Delete buffer   |
| `<leader>bn`       | Normal | Next buffer     |
| `<leader>bp`       | Normal | Previous buffer |

## Editing

| Keybinding | Mode   | Description                  |
| ---------- | ------ | ---------------------------- |
| `<A-j>`    | Normal | Move line down               |
| `<A-k>`    | Normal | Move line up                 |
| `<A-j>`    | Visual | Move selection down          |
| `<A-k>`    | Visual | Move selection up            |
| `<`        | Visual | Decrease indent and reselect |
| `>`        | Visual | Increase indent and reselect |

## UI & Terminal

| Keybinding   | Mode     | Description                |
| ------------ | -------- | -------------------------- |
| `<leader>e`  | Normal   | Open file explorer         |
| `<leader>tt` | Normal   | Toggle terminal            |
| `<leader>tf` | Normal   | Toggle floating terminal   |
| `<leader>th` | Normal   | Toggle horizontal terminal |
| `<leader>tv` | Normal   | Toggle vertical terminal   |
| `<Esc>`      | Terminal | Exit terminal mode         |

### Diagnostics

| Keybinding   | Mode   | Description           |
| ------------ | ------ | --------------------- |
| `<leader>xd` | Normal | Open diagnostic float |
| `<leader>xl` | Normal | Open diagnostic list  |
| `[d`         | Normal | Previous diagnostic   |
| `]d`         | Normal | Next diagnostic       |

## Plugin Keybindings

### Telescope

| Keybinding    | Mode   | Description         |
| ------------- | ------ | ------------------- |
| `<leader>ff`  | Normal | Find files          |
| `<leader>fg`  | Normal | Live grep           |
| `<leader>fb`  | Normal | Find buffers        |
| `<leader>fh`  | Normal | Help tags           |
| `<leader>fr`  | Normal | Recent files        |
| `<leader>fc`  | Normal | Grep current string |
| `<leader>fk`  | Normal | Find keymaps        |
| `<leader>fgc` | Normal | Git commits         |
| `<leader>fgb` | Normal | Git branches        |
| `<leader>fgs` | Normal | Git status          |

### Bufferline

| Keybinding         | Mode   | Description          |
| ------------------ | ------ | -------------------- |
| `<leader>bp`       | Normal | Pick buffer          |
| `<leader>bc`       | Normal | Pick buffer to close |
| `<leader>bh`       | Normal | Previous buffer      |
| `<leader>bl`       | Normal | Next buffer          |
| `<leader>bH`       | Normal | Move buffer left     |
| `<leader>bL`       | Normal | Move buffer right    |
| `<A-1>` to `<A-9>` | Normal | Go to buffer 1-9     |

### Harpoon

| Keybinding                   | Mode   | Description              |
| ---------------------------- | ------ | ------------------------ |
| `<leader>ha`                 | Normal | Add file to harpoon      |
| `<leader>hm`                 | Normal | Open harpoon menu        |
| `<leader>h1` to `<leader>h9` | Normal | Jump to harpoon file 1-9 |
| `<C-n>`                      | Normal | Next harpoon file        |
| `<C-p>`                      | Normal | Previous harpoon file    |

### Git

| Keybinding   | Mode   | Description          |
| ------------ | ------ | -------------------- |
| `<leader>gg` | Normal | Open LazyGit         |
| `<leader>gc` | Normal | Open LazyGit config  |
| `<leader>gf` | Normal | LazyGit current file |

### Copilot

| Keybinding   | Mode   | Description                      |
| ------------ | ------ | -------------------------------- |
| `<leader>cc` | Normal | Copilot chat                     |
| `<leader>ce` | Normal | Explain code                     |
| `<leader>cf` | Normal | Fix code                         |
| `<leader>co` | Normal | Optimize code                    |
| `<leader>cd` | Normal | Generate documentation           |
| `<leader>ct` | Normal | Generate tests                   |
| `<leader>cb` | Normal | Check best practices             |
| `<leader>ce` | Visual | Explain selected code            |
| `<leader>cf` | Visual | Fix selected code                |
| `<leader>co` | Visual | Optimize selected code           |
| `<leader>cd` | Visual | Document selected code           |
| `<leader>ct` | Visual | Generate tests for selected code |

### Neorg

| Keybinding    | Mode   | Description                  |
| ------------- | ------ | ---------------------------- |
| `<leader>nj`  | Normal | Open today's journal         |
| `<leader>nyt` | Normal | Open yesterday's journal     |
| `<leader>ntm` | Normal | Open tomorrow's journal      |
| `<leader>nw`  | Normal | Open workspace selector      |
| `<leader>nn`  | Normal | Switch to notes workspace    |
| `<leader>nwp` | Normal | Switch to personal workspace |
| `<leader>ntt` | Normal | Generate table of contents   |
| `<leader>ni`  | Normal | Inject metadata              |
| `<leader>nm`  | Normal | Update metadata              |
| `<leader>nc`  | Normal | Toggle concealer             |
| `<leader>nem` | Normal | Export to markdown           |
| `<leader>nl`  | Normal | Return to last workspace     |
| `<leader>nu`  | Normal | Iterate next list type       |
| `<leader>np`  | Normal | Iterate previous list type   |

### LeetCode

| Keybinding   | Mode   | Description              |
| ------------ | ------ | ------------------------ |
| `<leader>ll` | Normal | Open LeetCode            |
| `<leader>ld` | Normal | LeetCode daily challenge |
| `<leader>lr` | Normal | LeetCode random problem  |
| `<leader>ls` | Normal | Submit LeetCode solution |
| `<leader>lt` | Normal | Test LeetCode solution   |
