-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true -- Add relative line numbers
vim.o.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.smartcase = true -- Override 'ignorecase' if search pattern contains uppercase letters
vim.o.incsearch = true -- Show search matches as you type
vim.o.hlsearch = true -- Highlight all matches of the last search
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.o.splitright = true -- Configure how new splits should be opened
vim.o.splitbelow = true -- Configure how new splits should be opened

--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
vim.o.showmatch = true -- Highlight matching parentheses and brackets
vim.o.autoindent = true --Enable automatic indentation
vim.o.smartindent = true --Enable smart indentation
vim.o.shiftround = false --Round indent to multiple of 'hiftwidth'
vim.o.wrap = false -- Display lines as a long line.
vim.o.termguicolors = true --Allow 24-bit colors in the terminal
vim.opt.colorcolumn = '80' --make a coloured col at 80.
