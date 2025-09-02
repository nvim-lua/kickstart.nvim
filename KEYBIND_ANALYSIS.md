# Neovim Keybind Analysis

## Current Active Keybindings (Modular Config)

### Leader Key
- **Leader**: `<Space>`

### Core Navigation & Editing
- `<Esc>` - Clear search highlights (in normal mode)
- `<leader>q` - Open diagnostic quickfix list
- `<Esc><Esc>` - Exit terminal mode (in terminal)

### Window/Tmux Navigation
- `<C-h>` - Navigate to left window/tmux pane
- `<C-j>` - Navigate to down window/tmux pane
- `<C-k>` - Navigate to up window/tmux pane
- `<C-l>` - Navigate to right window/tmux pane
- `<C-\>` - Navigate to previous tmux pane

### Search & Files (`<leader>s*`)
- `<leader>sf` - **[S]earch [F]iles** - Find files in project
- `<leader>sg` - **[S]earch by [G]rep** - Live grep search
- `<leader>sh` - **[S]earch [H]elp** - Search help documentation
- `<leader>sk` - **[S]earch [K]eymaps** - Browse all keymaps
- `<leader>ss` - **[S]earch [S]elect Telescope** - Telescope picker
- `<leader>sw` - **[S]earch current [W]ord** - Search word under cursor
- `<leader>sd` - **[S]earch [D]iagnostics** - Browse diagnostics
- `<leader>sr` - **[S]earch [R]esume** - Resume last search
- `<leader>s.` - **[S]earch Recent Files** - Recently opened files
- `<leader>s/` - **[S]earch in Open Files** - Grep in open buffers
- `<leader>sn` - **[S]earch [N]eovim files** - Browse config files
- `<leader>/` - **Fuzzy search in current buffer**
- `<leader><leader>` - **Find existing buffers**

### LSP Operations
- `gd` - **[G]oto [D]efinition**
- `grr` - **[G]oto [R]eferences**
- `gri` - **[G]oto [I]mplementation**
- `grD` - **[G]oto [D]eclaration**
- `grt` - **[G]oto [T]ype definition**
- `grn` - **[G]oto [R]e[n]ame** - Rename symbol
- `gra` - **[G]oto code [A]ction** (also works in visual mode)
- `gO` - **[G]oto [O]pen document symbols**
- `gW` - **[G]oto [W]orkspace symbols**
- `K` - **Hover Documentation**
- `<leader>f` - **[F]ormat buffer**
- `<leader>lr` - **[L]SP [R]eload** all servers

### Diagnostics
- `[d` - Previous diagnostic message
- `]d` - Next diagnostic message
- `<leader>e` - Show diagnostic error messages (float)
- `<leader>q` - Open diagnostic quickfix list

### Git Operations (`<leader>g*`)
#### Fugitive Commands
- `<leader>gs` - **[G]it [S]tatus** - Open Git status
- `<leader>gd` - **[G]it [D]iff** - Show diff
- `<leader>gc` - **[G]it [C]ommit** - Create commit
- `<leader>gb` - **[G]it [B]lame** - Show blame
- `<leader>gl` - **[G]it [L]og** - View log
- `<leader>gp` - **[G]it [P]ush** - Push changes
- `<leader>gf` - **[G]it [F]etch** - Fetch from remote

#### Gitsigns Hunks (`<leader>h*`)
- `]c` - Jump to next git change
- `[c` - Jump to previous git change
- `<leader>hs` - **[H]unk [S]tage** - Stage current hunk
- `<leader>hr` - **[H]unk [R]eset** - Reset current hunk
- `<leader>hS` - **[H]unk [S]tage buffer** - Stage entire buffer
- `<leader>hu` - **[H]unk [U]ndo stage** - Undo stage hunk
- `<leader>hR` - **[H]unk [R]eset buffer** - Reset entire buffer
- `<leader>hp` - **[H]unk [P]review** - Preview hunk changes
- `<leader>hb` - **[H]unk [B]lame line** - Show blame for line
- `<leader>hd` - **[H]unk [D]iff** - Diff against index
- `<leader>hD` - **[H]unk [D]iff** - Diff against last commit
- `<leader>tb` - **[T]oggle [B]lame line** - Toggle inline blame
- `<leader>tD` - **[T]oggle [D]eleted** - Toggle deleted lines

### Debug Operations (DAP)
- `<F5>` - **Start/Continue** debugging
- `<F10>` - **Step Over**
- `<F11>` - **Step Into**
- `<F12>` - **Step Out**
- `<F7>` - **Toggle Debug UI**
- `<leader>db` - **[D]ebug [B]reakpoint** - Toggle breakpoint
- `<leader>dB` - **[D]ebug [B]reakpoint** - Set conditional
- `<leader>lp` - **[L]og [P]oint** - Set log point message
- `<leader>de` - **[D]ebug [E]val** - Evaluate expression
- `<leader>dr` - **[D]ebug [R]EPL** - Open REPL
- `<leader>dl` - **[D]ebug [L]ast** - Run last debug session
- `<leader>dh` - **[D]ebug [H]over** - Hover variables
- `<leader>ds` - **[D]ebug [S]copes** - View scopes
- `<leader>df` - **[D]ebug [F]rames** - View call frames
- `<leader>dt` - **[D]ebug [T]erminate** - Terminate session
- `<leader>dc` - **[D]ebug [C]ontinue** - Continue to cursor

### Completion (Blink.cmp)
- `<C-Space>` - Trigger/Show completion
- `<C-y>` - Accept completion
- `<C-e>` - Cancel/Hide completion
- `<C-n>` - Select next item
- `<C-p>` - Select previous item
- `<C-b>` - Scroll documentation up
- `<C-f>` - Scroll documentation down
- `<Tab>` - Next snippet placeholder
- `<S-Tab>` - Previous snippet placeholder

### GitHub Copilot
**Integration**: Copilot is installed (`zbirenbaum/copilot.lua`) and integrated with Blink.cmp.
- Copilot suggestions appear automatically in the completion menu
- Inline ghost text is disabled (handled by Blink.cmp instead)
- Use standard Blink.cmp keybindings to accept Copilot suggestions

Copilot commands:
- `:Copilot auth` - Authenticate with GitHub
- `:Copilot status` - Check Copilot status
- `:Copilot disable` - Disable Copilot
- `:Copilot enable` - Enable Copilot

### Text Objects (Mini.ai)
Enhanced text objects for better selection:
- `a` - Around (e.g., `daw` = delete around word)
- `i` - Inside (e.g., `ci"` = change inside quotes)
Common targets:
- `w` - Word
- `W` - WORD (includes punctuation)
- `p` - Paragraph
- `s` - Sentence
- `(`, `)`, `[`, `]`, `{`, `}` - Brackets
- `'`, `"`, `` ` `` - Quotes
- `<`, `>` - Angle brackets
- `t` - Tag (HTML/XML)

### Surround Operations (Mini.surround)
Default mappings:
- `sa` - Add surrounding (e.g., `saiw"` = surround word with quotes)
- `sd` - Delete surrounding (e.g., `sd"` = delete surrounding quotes)
- `sr` - Replace surrounding (e.g., `sr"'` = replace " with ')
- `sf` - Find surrounding
- `sF` - Find surrounding (left)
- `sh` - Highlight surrounding
- `sn` - Update MiniSurround.config.n_lines

### Comments (Comment.nvim)
- `gcc` - Toggle comment on current line
- `gc` - Toggle comment (motion/visual mode)
- `gbc` - Toggle block comment on current line
- `gb` - Toggle block comment (motion/visual mode)
Examples:
- `gcap` - Comment a paragraph
- `gc3j` - Comment current line and 3 lines below
- Visual mode: Select lines then `gc` to toggle

### Autopairs (nvim-autopairs)
Automatic bracket/quote pairing:
- When typing `(`, `[`, `{`, `'`, `"`, or `` ` ``, the closing pair is automatically inserted
- Pressing `<CR>` between pairs expands them properly
- Backspace removes both opening and closing pairs

### Indent Line (indent-blankline.nvim)
Visual indent guides are automatically shown - no keybindings needed

### Vim Sleuth
Automatically detects and sets indentation settings - no keybindings needed

### Illuminate (vim-illuminate)
Automatically highlights other occurrences of word under cursor - no keybindings needed
Navigation between occurrences:
- `<Alt-n>` or `]]` - Next occurrence (if configured)
- `<Alt-p>` or `[[` - Previous occurrence (if configured)

### Which-Key Groups
Groups that organize keybindings:
- `<leader>c` - **[C]ode** operations
- `<leader>d` - **[D]ocument/[D]ebug** operations
- `<leader>g` - **[G]it** operations
- `<leader>h` - **Git [H]unk** operations
- `<leader>r` - **[R]ename** operations
- `<leader>s` - **[S]earch** operations
- `<leader>t` - **[T]oggle** operations
- `<leader>w` - **[W]orkspace** operations

## Keybinding Architecture

### Organization Pattern
1. **Leader-based commands** - Most actions use `<leader>` (Space)
2. **Mnemonic prefixes** - First letter usually matches action (s=search, g=git, d=debug)
3. **LSP shortcuts** - Use `g` prefix for goto operations
4. **Function keys** - Reserved for debugging (F5, F7, F10-F12)
5. **Control combos** - Navigation and completion

### Configuration Locations
- **Core keymaps**: `lua/core/keymaps.lua` (custom LSP reload)
- **Kickstart defaults**: Built into respective plugin configurations
- **LSP keymaps**: `lua/plugins/config/lsp/keymaps.lua`
- **Telescope keymaps**: `lua/plugins/config/telescope.lua`
- **Git keymaps**: `lua/plugins/config/git.lua`
- **Debug keymaps**: `lua/plugins/config/debug/keymaps.lua`
- **Tmux navigation**: `lua/plugins/spec/nvim-tmux-navigator.lua`
- **Blink.cmp keymaps**: `lua/plugins/config/blink.lua`
- **Editor enhancements**: `lua/plugins/config/editor.lua` (Mini.nvim modules)
- **Which-key groups**: `lua/plugins/config/ui.lua`

## Tips for Learning Keybindings

1. **Use Which-key**: Press `<leader>` and wait to see available options
2. **Search keymaps**: Use `<leader>sk` to search all keybindings
3. **Mnemonic patterns**: Most bindings follow logical patterns (s=search, g=git, etc.)
4. **Check `:checkhealth core`**: Verify all features are working

## Customization Guide

To add new keybindings:
1. For general keymaps: Edit `lua/core/keymaps.lua`
2. For plugin-specific: Add to the relevant config file in `lua/plugins/config/`
3. Update Which-key groups in `lua/plugins/config/ui.lua` if adding new categories