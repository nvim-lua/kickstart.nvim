--  NOTE: Leader before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Margins
vim.opt.title = false -- in status, not great with tmux
vim.opt.number = true -- show line number
vim.opt.relativenumber = false
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.colorcolumn = '120'
-- vim.opt.breakindent = true

-- TODO: replace with osc52 provider once iTerm2 supports it better
if vim.env.DISPLAY then
  if vim.fn.executable 'xclip' == 1 then
    vim.schedule(function()
      vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
    end)
  end
  vim.opt.mouse = 'nvi'
end

-- File related
vim.opt.autochdir = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
if vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
  vim.opt.fileformats = 'dos,unix,mac'
elseif vim.fn.has 'mac' == 1 then
  vim.opt.fileformats = 'mac,unix,dos'
else
  vim.opt.fileformats = 'unix,dos,mac'
end
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest,list:full' -- list choices, expand singles
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open explorer [V]' })

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = false
vim.opt.inccommand = 'split' -- preview

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Windows
-- :sp/:vsp to split windows
-- C-w to jump between them
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Spelling: "z=" in normal to suggest replacements
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true, desc = 'Toggle [D]iagnostics' })

-- Highlight when yanking (copying) text - "yap"
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Install Lazy from Github
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- :Lazy
require('lazy').setup({

  require 'plugins.indentguess', -- Detects tabstop and shiftwidth to match orig
  require 'plugins.indent_line', -- Mark indent with vertical ruler (default as toggle off)
  require 'plugins.neovimacs', -- Emacs-style keybindings while in insert mode
  require 'plugins.gitsigns', -- Add git changes to gutter
  require 'plugins.which-key', -- Show keybindings as you go
  require 'plugins.telescope', -- Fuzzy finder (file & LSP search)
  require 'plugins.lsp', -- Language server (types, errors, signatures)
  require 'plugins.conform', -- Auto-reformat files on save
  require 'plugins.venv', -- Virtual environment selection
  require 'plugins.autocomplete', -- Auto-completion
  require 'plugins.colorscheme', -- Color scheme
  require 'plugins.misc', -- Misc small plugins
  require 'plugins.treesitter', -- Code highlights and reference navigation
  require 'plugins.todo', -- Highlight todo, notes in comments
  require 'plugins.tabnine', -- Tabnine LLM coding assistant

  -- Treesitter navigation
  -- :help nvim-treesitter
  -- :Telescope help_tags
  -- See `:help telescope` and `:help telescope.setup()`
  -- To see keymaps do this:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  -- Venv selector
  -- WIP: https://github.com/linux-cultist/venv-selector.nvim/tree/regexp
  -- Wait for a updated release
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Function to center current line vertically
--- C-l will recenter as well as refresh
local function recenter_vertically()
  local current_line = vim.fn.line '.'
  local window_height = vim.api.nvim_win_get_height(0)

  -- Calculate the ideal scroll position
  local scroll_offset = math.floor(window_height / 2)
  local target_top_line = math.max(1, current_line - scroll_offset)

  -- Set the window view
  vim.api.nvim_win_set_cursor(0, { current_line, 0 })
  vim.fn.winrestview { topline = target_top_line }
end
local function recenter_and_refresh()
  vim.cmd 'redraw!'
  recenter_vertically()
end
vim.keymap.set('n', '<C-l>', recenter_and_refresh, { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', recenter_and_refresh, { noremap = true, silent = true })
vim.keymap.set('c', '<C-s>', '<CR>n', { expr = true })

--- (Re)Undefine undesirable behavior
vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-a>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-x>', '<Nop>', { noremap = true })

-- Terminals/Shell
-- :terminal

-- Arrows keys for wildmenu
vim.keymap.set('c', '<Up>', 'pumvisible() ? "<C-p>" : "<Up>"', { expr = true, noremap = true })
vim.keymap.set('c', '<Down>', 'pumvisible() ? "<C-n>" : "<Down>"', { expr = true, noremap = true })
vim.keymap.set('c', '<Left>', 'pumvisible() ? "<C-b>" : "<Left>"', { expr = true, noremap = true })
vim.keymap.set('c', '<Right>', 'pumvisible() ? "<C-f>" : "<Right>"', { expr = true, noremap = true })
-- vim.opt.wildcharm = '<Tab>' -- set wildcharm=<C-Z>

-- LSP in insert mode
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
})

-- Tab management keys
-- F1-Prev, F2-Next, F3-New, F4-Close
--
local function safe_tabclose()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_windows = vim.call('win_findbuf', bufnr)
  local modified = vim.api.nvim_get_option_value('modified', { buf = bufnr })

  if vim.fn.tabpagenr '$' == 1 then
    -- last tab, no-op
    return
  elseif modified and #buf_windows == 1 then
    vim.ui.input({
      prompt = 'Buffer modified, are you sure? ',
    }, function(input)
      if input == 'y' then
        vim.cmd 'tabclose'
      end
    end)
  else
    vim.cmd 'tabclose'
  end
end
vim.keymap.set('t', '<F1>', vim.cmd.tabp, { noremap = true, silent = true })
vim.keymap.set('t', '<F2>', vim.cmd.tabn, { noremap = true, silent = true })
vim.keymap.set('t', '<F3>', '<C-\\><C-n>:tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '', '<C-\\><C-n>:tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<F4>', safe_tabclose, { noremap = true, silent = true })
vim.keymap.set('t', '<F5>', '<C-\\><C-n><Esc>:tab new<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F1>', vim.cmd.tabp, { noremap = true, silent = true })
vim.keymap.set('n', '<F2>', vim.cmd.tabn, { noremap = true, silent = true })
vim.keymap.set('n', '<F3>', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F4>', safe_tabclose, { noremap = true, silent = true })
vim.keymap.set('n', '<F5>', ':tab term<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<F1>', vim.cmd.tabp, { noremap = true, silent = true })
vim.keymap.set('i', '<F2>', vim.cmd.tabn, { noremap = true, silent = true })
vim.keymap.set('i', '<F3>', '<Esc>:tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '', '<Esc>:tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<F4>', safe_tabclose, { noremap = true, silent = true })
vim.keymap.set('i', '<F5>', '<Esc>:tab term<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tp', vim.cmd.tabn, { desc = 'Tab [p]revious' })
vim.keymap.set('n', '<leader>tn', vim.cmd.tabp, { desc = 'Tab [n]ext' })
vim.keymap.set('n', '<leader>to', vim.cmd.tabnew, { desc = 'Tab [o]pen' })
vim.keymap.set('n', '<leader>tc', safe_tabclose, { desc = 'Tab [c]lose' })
