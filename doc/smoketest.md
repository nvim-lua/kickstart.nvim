# Smoketest

A manual smoketest checklist to ensure features are working:

## Plugin

### Custom
- [ ] Oil
    - Shortcut `<leader>-` should open Oil
- [ ] Snacks
    - Should load dashboard at start, and `<leader>=` should open dashboard
    - `<leader>gb` should open the remote git repository in a browser
    - `<leader>gl` should open lazy git
    - `<leader>no` should open a scratchpad
    - `<leader>ns` browses existing notes in scratchpad
    - `<leader><C-t>` should open a terminal
- [ ] VimTmuxNavigator
    - Should be able to navigate between nvim and tmux panes using `<C-j>`, `<C-k>`, `<C-h>`, `<C-l>` for each respective direction

### Themes
- [ ] Catppuccin Theme
- [ ] Rose Pine Theme
