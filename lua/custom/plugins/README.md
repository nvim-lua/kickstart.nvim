# Custom ToggleTerm Setup

Quick notes on the terminal experience provided by `lua/custom/plugins/toggleterm.lua`.

## Highlights
- Floating terminals sized responsively to the current UI (`<C-\>` or `<leader>tf`).
- Dedicated splits: `<leader>th` (horizontal) and `<leader>tv` (vertical).
- Terminal picker `<leader>tt`, plus a pre-configured floating `lazygit` on `<leader>tg`.
- Send code to the primary terminal with `<leader>ts` (line or visual selection).
- Terminal windows inherit familiar navigation (`<Esc>`, `jk`, `<C-hjkl>`) automatically.

## Tips
- Use counts (`2ToggleTerm`, `3ToggleTerm`) when you want to retarget a specific layout.
- `TermExec cmd="npm run test"` reuses the floating terminal without stealing focus.
- Update sizing or borders in `float_opts` if your display or font spacing demands it.
