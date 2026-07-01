# Smoketest

A manual smoketest checklist to ensure features are working:

## Plugins
### Default
- [ ] Whichkey groups should have accurate keybindings
    - c -> LSP: [C]ode
    - g -> [G]it
    - n -> [N]otepad
    - r -> [R]e[N]ame
    - s -> [S]earch
    - t -> [T]oggle

### Kickstart
Kickstart plugins *that are enabled* should be working
- [ ] Autopairs
    - Brackets, parenthesis, etc, should automatically close
- [ ] Git Signs
    - `<leader>ghs` should stage a hunk of changes
    - `<leader>ghr` should reset a hunk of changes
    - `<leader>ghS` should stage a buffer of changes
    - `<leader>ghR` should reset a buffer of changes
    - `<leader>ghp` should preview changes in a git hunk
    - `<leader>gb` should show the git blame line
    - `<leader>gd` should show the git diff since the index
    - `<leader>gD` should show the git diff since the last commit
- [ ] IndentLine
    - Should see visual indentation guides for indented lines

### Custom
Custom plugins should be working
- [ ] Oil
    - Shortcut `<leader>-` should open Oil
- [ ] Snacks
    - Should load dashboard at start, and `<leader>=` should open dashboard
    - `<leader>gr` should open the remote git repository in a browser
    - `<leader>gl` should open lazy git
    - `<leader>no` should open a scratchpad
    - `<leader>ns` browses existing notes in scratchpad
    - `<leader><C-t>` should open a terminal
- [ ] VimTmuxNavigator
    - Should be able to navigate between nvim and tmux panes using `<C-j>`, `<C-k>`, `<C-h>`, `<C-l>` for each respective direction
- [ ] Remote SSHFS
    - Should be able to remotely access a directory using the `:RemoteSSHFSConnect` command
- [ ] Guttermarks
    - Marks (place a mark with `m<char>`) should be displayed in the gutter by their character

### Themes
- [ ] Catppuccin Theme
- [ ] Rose Pine Theme

## Settings
- [ ] Nerd fonts should be enabled
- [ ] Line numbers should be relative
- [ ] Virtual Diagnostic Lines (errors/warnings) should be beneath the applicable line
- [ ] Arrow key navigation should be disabled
- [ ] Should connect to godot server when running
- [ ] Files should format on save

## LSP

- [ ] LSP, autocomplete, and formatting should work for the following file types
    - Javascript `.js`, `.jsx`
    - Typescript `.ts`, `.tsx`
    - Svelte `.svelte`
    - C# `.cs`
    - Lua `.lua`
- [ ] Mason should ensure that the following tools are installed
    - Clangd
    - Pyright
    - Omnisharp
