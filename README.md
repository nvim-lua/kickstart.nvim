# nvim

Personal Neovim config based on `kickstart.nvim`, with custom plugins and
workflows for LSP, Git, and terminal-first editing.

## Quick checks

Use these commands after config changes:

```sh
nvim --headless "+qa"
nvim --headless "+checkhealth" "+qa"
luac -p init.lua lua/custom/**/*.lua
```

## Git workflow keymaps

- `<leader>gg`: open Neogit UI
- `<leader>gd`: open Diffview
- `<leader>gD`: close Diffview
- `<leader>gf`: file history in Diffview (current file)
- `<leader>gF`: repository history in Diffview
- `<leader>h...`: hunk actions from Gitsigns (`:which-key <leader>h`)

## LSP notes

- Vue support uses `vue_ls` plus `ts_ls` scoped to `vue` filetypes.
- `ts_ls` is wired with `@vue/typescript-plugin`, so `vue_ls` can forward
  TypeScript requests in `.vue` buffers.
- `typescript-tools.nvim` remains available for TypeScript/JavaScript workflows.

## Treesitter notes

- Uses the current API: `require('nvim-treesitter').setup()`.
- Config installs parsers from `ensure_installed` automatically when needed.

## Help docs

This repo ships a Vim help doc. After opening Neovim, run:

- `:help nvim-config`
