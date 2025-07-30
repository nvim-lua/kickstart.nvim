### Neovim Keybinds Cheatsheet

This cheatsheet provides a structured overview of keybindings found in your Neovim configuration files.

#### General Keymaps

* `<Esc>`: Clear highlights on search.

* `<leader>q`: Open diagnostic Quickfix list.

* `<Esc><Esc>`: Exit terminal mode.

* `<left>`: Echo "Use h to move left!!".

* `<right>`: Echo "Use l to move right!!".

* `<up>`: Echo "Use k to move up!!".

* `<down>`: Echo "Use j to move down!!".

* `<C-h>`: Move focus to the left window.

* `<C-l>`: Move focus to the right window.

* `<C-j>`: Move focus to the lower window.

* `<C-k>`: Move focus to the upper window.

#### GitSigns Keymaps

* `n`\]c\`: Jump to next git change (normal mode).

* `n`\[`c`: Jump to previous git change (normal mode).

* `v`<leader>hs\`: Stage hunk (visual mode).

* `v`<leader>hr\`: Reset hunk (visual mode).

* `n`<leader>hs\`: Stage hunk (normal mode).

* `n`<leader>hr\`: Reset hunk (normal mode).

* `n`<leader>hS\`: Stage buffer (normal mode).

* `n`<leader>hu\`: Undo stage hunk (normal mode).

* `n`<leader>hR\`: Reset buffer (normal mode).

* `n`<leader>hp\`: Preview hunk (normal mode).

* `n`<leader>hb\`: Blame line (normal mode).

* `n`<leader>hd\`: Diff against index (normal mode).

* `n`<leader>hD\`: Diff against last commit (normal mode).

* `n`<leader>tb\`: Toggle git show blame line (normal mode).

* `n`<leader>tD\`: Toggle git show Deleted (normal mode).

#### Debugging Keymaps

* `<F5>`: Start/Continue debugging.

* `<F1>`: Step Into.

* `<F2>`: Step Over.

* `<F3>`: Step Out.

* `<leader>b`: Toggle Breakpoint.

* `<leader>B`: Set Breakpoint (with condition prompt).

* `<F7>`: See last session result.

#### Telescope Keymaps

* `<leader>sh`: Search Help.

* `<leader>sk`: Search Keymaps.

* `<leader>sf`: Search Files.

* `<leader>ss`: Select Telescope Builtins.

* `<leader>sw`: Search current Word.

* `<leader>sg`: Search by Grep.

* `<leader>sd`: Search Diagnostics.

* `<leader>sr`: Resume last search.

* `<leader>s.`: Search Recent Files.

* `<leader><leader>`: Find existing buffers.

* `<leader>/`: Fuzzily search in current buffer.

* `<leader>s/`: Live Grep in Open Files.

* `<leader>sn`: Search Neovim files (in config directory).

#### LSP (Language Server Protocol) Keymaps

* `grn`: \[R\]e\[n\]ame.

* `gra`: \[G\]oto Code \[A\]ction (normal and visual modes).

* `grr`: \[G\]oto \[R\]eferences.

* `gri`: \[G\]oto \[I\]mplementation.

* `grd`: \[G\]oto \[D\]efinition.

* `grD`: \[G\]oto \[D\]eclaration.

* `gO`: Open Document Symbols.

* `gW`: Open Workspace Symbols.

* `grt`: \[G\]oto \[T\]ype Definition.

* `<leader>th`: [T]oggle Inlay [H]ints.

#### Neo-tree Keymaps

* `<leader>e`: Toggle Neo-tree.

* `<leader>E`: Reveal current file in Neo-tree.

* `<leader>b`: Toggle Neo-tree (buffers).

* `<leader>g`: Toggle Neo-tree (git_status).

#### Conform (Autoformat) Keymaps

* `<leader>f`: Format buffer.

