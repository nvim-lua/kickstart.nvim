vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '120'

-- indent via Tab
vim.keymap.set('n', '<Tab>', '>>_')
vim.keymap.set('n', '<S-Tab>', '<<_')
vim.keymap.set('v', '<Tab>', '>>_')
vim.keymap.set('v', '<S-Tab>', '<<_')
vim.keymap.set('i', '<Tab>', '\t')
vim.keymap.set('i', '<S-Tab>', '\b')

-- Mapping U to Redo.
vim.keymap.set('', 'U', '<C-r>')
vim.keymap.set('', '<C-r>', '<NOP>')

vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'kj', '<ESC>')
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', 'kk', '<ESC>')

-- fast scrolling
vim.keymap.set('n', '<leader>n', '20j')
vim.keymap.set('n', '<leader>u', '20k')
vim.keymap.set('v', '<leader>n', '20j')
vim.keymap.set('v', '<leader>u', '20k')

-- Alternate way to save
vim.cmd('nnoremap <C-s> :w!<CR>')
vim.cmd('inoremap <C-s> <ESC> :w!<CR>')

-- Alternate way to quit
vim.cmd('nnoremap <S-c> :q!<CR>')

-- ================= File management ================= --

-- swapfile has global & local config, eventhough help says otherwise
vim.o.swapfile = false -- can open already open files
vim.bo.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.autoread = true -- auto file change detection

-- ================= Scrolling ================= --

vim.o.scrolloff = 999 -- start scrolling when 8 lines away from margins

-- ================= Indentation ================= --

-- pay attention to 'vim.bo' (buffer local options) and 'vim.o' (global options)
-- see :help options.txt

-- for some reason these values need to be set in both o and bo objects
-- eventhough these options are supposed to be local to buffer
vim.o.tabstop = 4 -- maximum width of tab character (measured in spaces)
vim.bo.tabstop = 4
vim.o.shiftwidth = 4 -- size of indent (measured in spaces), should equal tabstop
vim.bo.shiftwidth = 4
vim.o.softtabstop = 4 -- should be the same as the other two above
vim.bo.softtabstop = 4
vim.o.expandtab = true -- expand tabs to spaces
vim.bo.expandtab = true -- expand tabs to spaces
vim.o.smartindent = true -- smart indenting on new line for C-like programs
vim.bo.smartindent = true
vim.o.autoindent = true -- copy the indentation from previous line
vim.bo.autoindent = true
vim.o.smarttab = true -- tab infront of a line inserts blanks based on shiftwidth

-- ================= Search ================= --

vim.o.ignorecase = true -- Ignorecase when searching
vim.o.incsearch = true -- start searching on each keystroke
vim.o.smartcase = true -- ignore case when lowercase, match case when capital case is used
vim.o.hlsearch = true -- highlight the search results

-- ================= Performance ================= --

vim.o.lazyredraw = true -- useful for when executing macros.
vim.o.ttimeoutlen = 10 -- ms to wait for a key code seq to complete

-- ================= Misc ================= --

vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.wrap = false -- don't wrap long text into multiple lines
vim.o.history = 10000 -- numbers of entries in history for ':' commands and search patterns (10000 = max)
vim.o.updatetime = 300 -- used for CursorHold event (for document highlighting detection)
vim.o.mouse = 'nv' -- allow mose in normal & visual mode

-- better autocomplete behaviour
-- menuone - show popup menu also when there is only one match available
-- preview - show extra information about currently selected completion
-- noinsert - do not insert any text for match until the user selects it from the menu
vim.o.completeopt = 'menuone,preview,noinsert'

-- allows hidden buffers
-- this means that a modified buffer doesn't need to be saved when changing
-- tabs/windows.
vim.o.hidden = true

-- Copy paste between vim and everything else
vim.o.clipboard = "unnamedplus"

-- diagnostic symbols
local signs = {Error = "", Warn = "", Hint = "", Info = ""}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
