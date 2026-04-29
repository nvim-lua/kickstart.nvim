# NVIM HELPERS

## Moving around

Official documentation [here](https://neovim.io/doc/user/usr_03.html)

- `gg` go to the beginning of the files
- `G` go to the end of the files
- `nG` go to the nth line of the files
- `0` go to the beginning of the lines
- `$` go to the end of the lines
- `w` go to the beginning of the next word
- `b` go to the beginning of the previous word
- `e` go to the end of the current word
- `H` go to the top of the screen
- `M` go to the middle of the screen
- `L` go to the bottom of the screen
- `{` go to the beginning of the previous paragraph
- `}` go to the beginning of the next paragraph
- `Ctrl + d` go down half a screen
- `Ctrl + u` go up half a screen
- `Ctrl + f` go down a full screen
- `Ctrl + b` go up a full screen
- `*` search for the word under the cursor
- `#` search for the word under the cursor in reverse direction

- `gd` go to the definition of the word under the cursor
- `gD` go to the declaration of the word under the cursor
- `gi` go to the implementation of the word under the cursor
- `gr` go to the references of the word under the cursor
- `Ctrl + o` go to the previous location in the jump list



## Replace regex in selected lines

```vim
:%s/old/new/g
```

## Add a comment to selected lines

```vim
:'<,'>s/^/# /g
```

## Find and replace in all files

- Open telescope file browser `<leader>sf`

- Then, write the command to find and replace in all files

```bash
:cdo %s/old/new/gc # apply the change to the resutlt
:cfdo %s/old/new/gc # apply the change to the current file
```

## Add a tab to selected lines

- Select the lines in visual mode

- click `>` to add a tab
- click `<` to remove a tab

Aslo add the number of tabs you want to add/remove before clicking `>` or `<`. For example, `3>` will add 3 tabs to the selected lines.



## Repeat or undo last action

- click `.` to repeat the last action
- click `u` to undo the last action


## Fold and unfold shortcuts

[Reference](https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/)

- `za` toggle Fold
- `zR` unfold all
- `zM` fold all
- `zk` fold one level up
- `zj` unfold one level down

## Buffer management

- `:%bd|e#` to close all Buffers except the current one
- `:bnext` or `:bn` to go to the next Buffer
- `:bprev` or `:bp` to go to the previous Buffer
- `:bdelete` or `:bd` to delete the current Buffer


## Change the colorscheme

- `:colorscheme <name_of_colorscheme>` to change the colorscheme

## Split windows

- `Ctrl + w + s` to split the window horizontally
- `Ctrl + w + v` to split the window vertically
- `Ctrl + w + w` to switch between windows
- `Ctrl + w + q` to close the current window
- `Ctrl + w + h` to move to the left window
- `Ctrl + w + j` to move to the bottom window
- `Ctrl + w + k` to move to the top window
- `Ctrl + w + l` to move to the right window
- `Ctrl + w + =` to make all windows equal size
- `Ctrl + w + _` to make the current window the full height
- `Ctrl + w + |` to make the current window the full width
- `Ctrl + w + o` to close all other windows except the current one
- `:split <file_path>` to split the window horizontally and open a file
- `:vsplit <file_path>` to split the window vertically and open a file
- `:new` to open a new empty windows
- `:vnew` to open a new empty windows vertically
- `:close` to close the current windows
- `:only` to close all other windows except the current one
- `Ctrl + w + < or >` to adjust the width of the current windows
- `Ctrl + w + + or -` to adjust the height of the current windows

## Git Conflicts mappings

- ]x - move to the next conflict
- [x - move to the previous conflict
- co - choose the current change
- ci - choose the incoming change
- cb - choose both changes
- c0 - choose none of the changes

