--  NOTE: Leader before plugins are loaded (otherwise wrong leader will be used)

-- Check Neovim version requirement
if vim.fn.has 'nvim-0.11' == 0 then
  vim.api.nvim_err_writeln 'Error: Neovim 0.11 or higher is required for this configuration.'
  vim.api.nvim_err_writeln('Current version: ' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch)
  vim.api.nvim_err_writeln 'Please update Neovim to continue.'
  return
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- User settings
vim.g.tabnine_enable = true -- JCM
vim.g.autocomplete_enable = true
-- vim.o.autochdir = true -- to open from buffer dir
vim.g.format_on_save_enabled = true

-- Add emacs/rl keybindings to this configuration?
vim.g.neovimacs_bindings = true
vim.g.neovimacs_insert = true

-- Margins
vim.o.title = false -- in status, not great with tmux
vim.o.number = true -- show line number
vim.o.relativenumber = false
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.colorcolumn = '120'
vim.o.guicursor = 'n-v-i-c:block-Cursor' -- keep block cursor
-- vim.o.breakindent = true

-- TODO: replace with osc52 provider once iTerm2 supports it better
if vim.env.DISPLAY then
  if vim.fn.executable 'xclip' == 1 then
    vim.schedule(function()
      vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
    end)
  end
  vim.o.mouse = 'nvi'
end

-- File related
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.undodir = os.getenv 'HOME' .. '/.vim/undodir'
if vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
  vim.o.fileformats = 'dos,unix,mac'
elseif vim.fn.has 'mac' == 1 then
  vim.o.fileformats = 'mac,unix,dos'
else
  vim.o.fileformats = 'unix,dos,mac'
end
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest,list:full' -- expand to longest match, then list choices
vim.keymap.set('n', '<leader>p', '', { desc = '[P] +Explore' })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open explorer [V]' })

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrapscan = false
vim.o.inccommand = 'split' -- preview

-- Performance
vim.o.updatetime = 250
vim.o.timeoutlen = 3000

-- Windows
-- :sp/:vsp to split windows
-- C-w to jump between them
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Spelling: "z=" in normal to suggest replacements
vim.o.spelllang = 'en_us'
vim.o.spell = true

-- Quick diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[Q]uickfix diagnostics' })

-- Allow 'q' to close simple diagnostic windows
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf', 'help', 'checkhealth' },
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>bd<cr>', { silent = true, buffer = true })
  end,
})

-- Highlight when yanking (copying) text - "yap"
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('ks-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Install Lazy from Github
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- :Lazy
require('lazy').setup({

  require 'plugins.indentguess', -- Detects tabstop and shiftwidth to match orig
  require 'plugins.indent_line', -- Mark indent with vertical ruler (default as toggle off)
  require 'plugins.neovimacs', -- Emacs-style keybindings while in insert mode
  require 'plugins.bufferline', -- Filename header tabs
  require 'plugins.gitsigns', -- Add git changes to gutter
  require 'plugins.which-key', -- Show keybindings as you go
  require 'plugins.telescope', -- Fuzzy finder (file & LSP search)
  require 'plugins.lualine', -- Statusbar at bottom
  require 'plugins.mason', -- Mason: LSP/DAP/Linter/Formatter installer
  require 'plugins.conform', -- Auto-reformat files on save
  require 'plugins.claude-code', -- LLM: Claude Code
  require 'plugins.venv', -- Virtual environment selection
  require 'plugins.autocomplete-blink', -- Auto-completion (new, incomplete)
  require 'plugins.colorscheme', -- Color scheme
  require 'plugins.mini', -- Misc small plugins
  require 'plugins.treesitter', -- Code highlights and reference navigation
  require 'plugins.todo', -- Highlight todo, notes in comments
  require 'plugins.avante', -- LLM: Cursor alternative
  require 'plugins.tabnine', -- LLM: Tabnine coding assistant
  require 'plugins.tiny-inline-diagnostics', -- Better diagnostics
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

--- (Re)Undefine undesirable behavior
if vim.g.neovimacs_bindings then
  vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-a>', '<Nop>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-x><C-c>', ':confirm qall<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-x><C-s>', ':update<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-x><C-f>', ':hide edit ', { noremap = true })
end

-- Terminals/Shell
-- :terminal

-- Arrows keys for wildmenu
vim.keymap.set('c', '<Up>', 'pumvisible() ? "<C-p>" : "<Up>"', { expr = true, noremap = true })
vim.keymap.set('c', '<Down>', 'pumvisible() ? "<C-n>" : "<Down>"', { expr = true, noremap = true })
vim.keymap.set('c', '<Left>', 'pumvisible() ? "<C-b>" : "<Left>"', { expr = true, noremap = true })
vim.keymap.set('c', '<Right>', 'pumvisible() ? "<C-f>" : "<Right>"', { expr = true, noremap = true })

-- LSP diagnostics configuration
vim.diagnostic.config { virtual_text = false }

-- vim.diagnostic.config {
--  virtual_text = {
--    source = 'if_many',
--  },
--  signs = true,
--  underline = true,
--  update_in_insert = true,
--  severity_sort = true,
--}

-- Register and enable LSP servers
-- See https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
-- for sample starter configurations.
local lsp_servers = {
  'ast_grep',
  'clangd',
  'lua_ls',
  'bashls',
  'marksman',
  'python',
  'taplo',
  'yamlls',
  'ts_ls',
  'dockerls',
}
-- Conditional on executables
if vim.fn.executable 'go' == 1 then
  table.insert(lsp_servers, 'gopls')
end
if vim.fn.executable 'nixd' == 1 then
  table.insert(lsp_servers, 'nil_ls')
end

require 'lsp/keybindings'
for _, server in ipairs(lsp_servers) do
  local ok, config = pcall(require, 'lsp.' .. server)
  if ok and config.name then
    vim.lsp.config[config.name] = config
    vim.lsp.enable(server)
  end
end

-- Inlay hints?
vim.lsp.inlay_hint.enable(true)

require 'utils/windows'
