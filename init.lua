--[[
Run `:checkhealth` if you run into any issues.

LUA HELP
  - https://learnxinyminutes.com/docs/lua/
  - `:help lua-guide`/ https://neovim.io/doc/user/lua-guide.html
  - `:Tutor`
  - `:help` - Look here when you get stuck
  - "<space>sh" - [S]earch [H]elp documentation
--]]

-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' ' -- Set <space> as the leader key
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

--=============================================================================
-- SETTING OPTIONS
-- `:help vim.o` / for more options `:help option-list`
--=============================================================================
vim.o.number = true -- Make line number default
vim.o.relativenumber = true -- enable relative line numbers

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
-- vim.opt.expandtab = false   -- if true then convert tabs to spaces

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

--=============================================================================
-- BASIC KEYMAPS
-- `:help vim.keymap.set()`
--=============================================================================
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Teest shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

--=============================================================================
-- BASIC AUTOCOMMANDS
-- `:help lua-guide-autocommands`
--=============================================================================

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Terminal auto command
-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Opens Terminal in Nvim',
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function(args)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0

    -- terminal-mode mappings (buffer-local)
    vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], { buffer = args.buf, silent = true })
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { buffer = args.buf, silent = true })
  end,
})

local job_id = 0
vim.keymap.set('n', '<space>st', function()
  vim.cmd.vnew()
  vim.cmd.wincmd 'J' -- Sets terminal to bottom
  vim.api.nvim_win_set_height(0, 20)
  vim.wo.winfixheight = true
  vim.cmd.term()

  job_id = vim.b.terminal_job_id
end)

-- Build command
vim.keymap.set('n', '<space>build', function()
  vim.fn.chansend(job_id, 'build\r\n')
end)

--=============================================================================
-- INSTALL `lazy.nvim` plugin manager
-- `:help lazy.nvim.txt` / https://github.com/folke/lazy.nvim

--  Check the current status of your plugins, run `:Lazy`
--  Update plugins you can run `:Lazy update`
--=============================================================================

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

--=============================================================================
-- INSTALL PLUGINS HERE
--=============================================================================
require('lazy').setup({
  --=============================================================================
  -- INDENT DETECTION (guess-indent.nvim)

  -- Automatically detects a file’s indentation style (tabs vs spaces) and sets tabstop/shiftwidth accordingly.
  --=============================================================================
  {
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('guess-indent').setup {}
    end,
  },
  -- Here is a more advanced example where we pass configuration options to `gitsigns.nvim`.
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    evnet = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  --=============================================================================
  -- COLOUR SCHEME
  --=============================================================================

  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.o.background = 'dark'

      vim.g.sonokai_style = 'espresso'
      vim.g.sonokai_disable_italic_comment = 1
      vim.g.sonokai_better_performance = 1

      vim.cmd.colorscheme 'sonokai'
    end,
  },

  --=============================================================================
  -- CUSTOM PLUGINS
  -- lazydev, lsp, telescope, conform, autocompletion
  --=============================================================================
  { import = 'custom.plugins' },

  --=============================================================================
  -- COMMENT ANNOTATIONS (todo-comments.nvim)

  -- Highlights and helps you browse TODO/FIXME/NOTE-style keywords in comments across your codebase.
  --=============================================================================
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      highlight = {
        -- Require TODO tags to be written as TODO: / TODO( to avoid false positives.
        -- Case-sensitive so words like "Not" don't trigger NOTE highlighting.
        pattern = [=[.*\C<(KEYWORDS)\s*[:(]]=],

        multiline = false,
      },
      search = {
        -- Keep search consistent with highlight rules.
        pattern = [=[\C\b(KEYWORDS)\b\s*[:(]]=],
      },
    },
  },

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
