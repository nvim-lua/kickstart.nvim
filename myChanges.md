# Changes made to base nvim-Kickstart
## working LSP
### ez
- python
### needs project file
- c++ (kind of picky, single file mode doesn't work well)
- F#  (kind of picky, single file mode doesn't work well)
- rust  🦀 (.rsx files seem to work in single file mode)

## Settings
### nvim general settings
- set indents as 4 'space' characters
### nvim gui settings
- neovide gui
    - added cursor trail config
    - set font to NerdFonts / Hack h16
### Language server settings
- added server inits for:
    - clangd
    - pyright
    - rust_analyzer
    - tsserver
    - fsautocomplete
    - jdtls
## Plugins
- 'RishabhRD/nvim-lsputils' added for better lsp default settings
-  'folke/trouble.nvim' to view error messages at bottom
    -  'nvim-tree/nvim-web-devicons' for icon support in trouble
### Misc
- set 'treesitter :: auto_install = true. should auto install grammars 
- telescope fzf converted to use windows ripgrep

## Mappings
### Normal Mode
- 'yf' copies path to current file to register f and F
- 'K' inserts a line break left of cursor and places cursor on first non white-space character
- 'gh' for lsp hover docs
- 'gH' for lsp signature docs
### Insert Mode
- 'JJ' easily exits insert mode (even in terminal mode)
## FileType Scripts
### F# 
- visual mode (selection)
    - added <alt-return> binding to run selected code in FSI, similar to visual studio
    