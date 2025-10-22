# Custom Plugins Setup

## ToggleTerm

Quick notes on the terminal experience provided by `lua/custom/plugins/toggleterm.lua`.

### Highlights
- Floating terminals sized responsively to the current UI (`<C-\>` or `<leader>tf`).
- Dedicated splits: `<leader>th` (horizontal) and `<leader>tv` (vertical).
- Terminal picker `<leader>tt` to switch between multiple terminals.
- Send code to the primary terminal with `<leader>ts` (line or visual selection).
- Terminal windows inherit familiar navigation (`<Esc>`, `jk`, `<C-hjkl>`) automatically.

### Tips
- Use counts (`2ToggleTerm`, `3ToggleTerm`) when you want to retarget a specific layout.
- `TermExec cmd="npm run test"` reuses the floating terminal without stealing focus.
- Update sizing or borders in `float_opts` if your display or font spacing demands it.

## LazyGit

Enhanced git interface using `lua/custom/plugins/lazygit.lua`.

### Highlights
- Fast, native lazygit integration with no keyboard shortcut conflicts
- Opens in a proper floating window (95% of screen size)
- Fully functional with all lazygit features and keybindings
- Use `<leader>gg` to open lazygit in current repo
- Use `<leader>gf` to open lazygit focused on current file history

### Why Not ToggleTerm?
LazyGit.nvim is used instead of toggleterm for lazygit because:
- Better performance (uses native terminal, not Neovim's terminal emulator)
- No keyboard shortcut conflicts (q, Esc, etc. work as expected)
- Designed specifically for lazygit integration
- Supports editing commit messages in Neovim
