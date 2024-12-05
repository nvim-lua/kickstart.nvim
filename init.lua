--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

Kickstart.nvim is *Cannot access configuration for mutt_ls. Ensure this server is listed in `server_configurations.md` or added as a custom serverCannot access configuration for mutt_ls. Ensure this server is listed in `server_configurations.md` or added as a custom serverCannot access configuration for mutt_ls. Ensure this server is listed in `server_configurations.md` or added as a custom servernot* a distribution.

Kickstart.nvim is a starting point for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you can start exploring, configuring and tinkering to
  make Neovim your own! That might mean leaving Kickstart just the way it is for a while
  or immediately breaking it into modular pieces. It's up to you!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example which will only take 10-15 minutes:
    - https://learnxinyminutes.com/docs/lua/

  After understanding a bit more about Lua, you can use `:help lua-guide` as a
  reference for how Neovim integrates Lua.
  - :help lua-guide
  - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

  If you don't know what this means, type the following:
    - <escape key>
    - :
    - Tutor
    - <enter key>

  (If you already know the Neovim basics, you can skip this step.)

Once you've completed that, you can continue working through **AND READING** the rest
of the kickstart init.lua.

Next, run AND READ `:help`.
  This will open up a help window with some basic information
  about reading, navigating and searching the builtin help documentation.

  This should be the first place you go to look when you're stuck or confused
  with something. It's one of my favorite Neovim features.

  MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
  which is very useful when you're not exactly sure of what you're looking for.

I have left several `:help X` c
~                                       │   38omments throughout the init.lua
  These are hints about where to find more information about the relevant settings,
  plugins or Neovim features used in Kickstart.

 NOTE: Look for lines like this

  Throughout the file. These are for you, the reader, to help you understand what is happening.
  Feel free to delete them once you know what you're doing, but they should serve as a guide
  for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>w', '<C-w>', { desc = 'Windows' })
-- vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = 'Switch [W]indow' })
-- vim.keymap.set('n', '<leader>wc', '<C-w>c', { desc = '[C]lose window' })
-- vim.keymap.set('n', '<leader>w+', '<C-w>+', { desc = 'Increase size' })
-- vim.keymap.set('n', '<leader>w-', '<C-w>-', { desc = 'Decrease size' })

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- vim.keymap.set('n', '<leader>wh', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<leader>wl', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<leader>wj', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<leader>wk', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup 'plugins'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
--
-- Add support for Rocks installer

local rocks_config = {
  rocks_path = vim.env.HOME .. '/.local/share/nvim/rocks',
  luarocks_binary = vim.env.HOME .. '/.local/share/nvim/rocks/bin/luarocks',
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
  vim.fs.joinpath(rocks_config.rocks_path, 'share', 'lua', '5.1', '?.lua'),
  vim.fs.joinpath(rocks_config.rocks_path, 'share', 'lua', '5.1', '?', 'init.lua'),
}
package.path = package.path .. ';' .. table.concat(luarocks_path, ';')

local luarocks_cpath = {
  vim.fs.joinpath(rocks_config.rocks_path, 'lib', 'lua', '5.1', '?.so'),
  vim.fs.joinpath(rocks_config.rocks_path, 'lib64', 'lua', '5.1', '?.so'),
  -- Remove the dylib and dll paths if you do not need macos or windows support
  vim.fs.joinpath(rocks_config.rocks_path, 'lib', 'lua', '5.1', '?.dylib'),
  vim.fs.joinpath(rocks_config.rocks_path, 'lib64', 'lua', '5.1', '?.dylib'),
  vim.fs.joinpath(rocks_config.rocks_path, 'lib', 'lua', '5.1', '?.dll'),
  vim.fs.joinpath(rocks_config.rocks_path, 'lib64', 'lua', '5.1', '?.dll'),
}
package.cpath = package.cpath .. ';' .. table.concat(luarocks_cpath, ';')

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, 'lib', 'luarocks', 'rocks-5.1', '*', '*'))

-- Use spaces for tabs
vim.cmd 'set expandtab'
vim.cmd 'set tabstop=2'
vim.cmd 'set softtabstop=2'
vim.cmd 'set shiftwidth=2'

-- Oil plugin
require('oil').setup()
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Neogit plugin
vim.keymap.set('n', '<Leader>gg', ':Neogit<CR>', { desc = 'Neogit open' })

-- set conceal level bc obsidian plugin requires this:
vim.opt.conceallevel = 1
