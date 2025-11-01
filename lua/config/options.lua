-- [[ Setting options ]]
-- See `:help vim.opt`
-- See `:help vim.o`
-- See `:help option-list`

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setup Node.js PATH for plugins like Copilot ]]
-- Add fnm's Node.js to PATH so Neovim can find it
-- This is required for GitHub Copilot and other Node.js based plugins
-- Uses fnm's alias resolution to always point to the default/latest version
local home = vim.env.HOME
local fnm_node_path = home .. '/.local/share/fnm/aliases/default/bin'
-- Fallback: also add the fnm multishell path if it exists
local fnm_multishell = home .. '/.local/state/fnm_multishells'
if vim.fn.isdirectory(fnm_node_path) == 1 then
  vim.env.PATH = fnm_node_path .. ':' .. vim.env.PATH
elseif vim.fn.isdirectory(fnm_multishell) == 1 then
  -- If multishell is being used, fnm will handle it via shell integration
  -- We just need to ensure the PATH includes typical fnm locations
  vim.env.PATH = home .. '/.local/share/fnm:' .. vim.env.PATH
end

-- Make line numbers default
vim.o.number = true

-- Enable relative line numbers for easier jumping
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- See `:help 'list'` and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- ========================================================================
-- FOLDING CONFIGURATION - For Flutter widgets and code blocks
-- ========================================================================
-- Enable folding based on Treesitter (for Flutter widgets, functions, etc.)
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Start with all folds open (don't fold on file open)
vim.o.foldenable = false

-- Set fold level (higher = more unfolded by default)
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- Customize fold text to show more context
vim.o.foldtext = ''

-- Hide fold column globally (saves space, folds still work with za/zc/zo)
-- Set to '1' if you want the fold column back
vim.o.foldcolumn = '0'

-- Folding keymaps:
--   za - Toggle fold under cursor
--   zc - Close fold under cursor
--   zo - Open fold under cursor
--   zM - Close all folds
--   zR - Open all folds
--   zj - Move to next fold
--   zk - Move to previous fold
