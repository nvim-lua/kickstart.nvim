## Code folding

To see the code fold in left gutter.
set foldcolumn=1

### Creating fold
#### Set coding folding mode
:set foldmethod=manual

#### Creating a manual fold
1. First select a section of lines in visual mode.
2. Press `zf` to create fold, it is `zd` to delete the same fold.
3. `zo` to open fold, `zc` to close fold, `za` to toggle open/close fold


#### Creating indent fold
:set foldmethod=indent


#### Creating expr fold using nvim-treesitter
:set foldlevel=2
:set foldmethod=expr
:set foldexpr=nvim_treesitter#foldexpr()


vim.wo.foldmethod = 'expr'
