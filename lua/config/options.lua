local opt = vim.opt
local g = vim.g

local opts = {
  -- Change cursor in insert mode
  guicursor = '',

  -- set terminal tab title
  title = true,
  titlelen = 0,
  -- titlestring = 'nvim %t (%-15.25F)%a%r%m',
  titlestring = 'nvim %t (%-15.25f)%a%r%m',

  -- Make line numbers default
  relativenumber = true,

  --Enable noshowmode
  showmode = false,

  -- Enable break indent
  breakindent = true,

  -- Indent Configuration
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  expandtab = true,

  -- Disable line wrap
  wrap = false,

  -- Save undo history
  swapfile = false,
  backup = false,
  undodir = vim.fn.stdpath('data') .. '/site/undodir',
  undofile = true,

  -- Searching Configuration
  hlsearch = false,
  incsearch = true,

  -- Case-insensitive searching UNLESS \C or capital in search
  ignorecase = true,
  smartcase = true,

  -- Decrease update time
  updatetime = 50,
  timeoutlen = 300,

  -- Set completeopt to have a better completion experience
  completeopt = 'menuone,noselect',

  -- NOTE: You should make sure your terminal supports this
  termguicolors = true,
  scrolloff = 10,
  pyxversion = 3,

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See :help 'list'
  --  and :help 'listchars'
  list = true,
  listchars = { tab = '  ', trail = '·', nbsp = '␣' },

  -- Preview substitutions live, as you type!
  inccommand = 'split',
}

for k, v in pairs(opts) do
  opt[k] = v
end

local win_local = {
  signcolumn = 'yes',
  number = true,
}

for k, v in pairs(win_local) do
  vim.wo[k] = v
end

-- Disable built-in plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'matchit',
  -- "netrw",
  'netrwFileHandlers',
  'loaded_remote_plugins',
  'loaded_tutor_mode_plugin',
  -- "netrwPlugin",
  -- "netrwSettings",
  'rrhelper',
  'spellfile_plugin',
  'tar',
  'tarPlugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
  'matchparen',
}

for _, plugin in pairs(disabled_built_ins) do
  g['loaded_' .. plugin] = 1
end

-- Improve Neovim startup
local global_let_opts = {
  loaded_python_provider = 0,
  loaded_python3_provider = 0,
  python_host_skip_check = 1,
  python3_host_skip_check = 1,
  python3_host_prog = '/usr/local/bin/python3',
  EditorConfig_core_mode = 'external_command',
  matchparen_timeout = 20,
  matchparen_insert_timeout = 20,
}

for k, v in pairs(global_let_opts) do
  g[k] = v
end

opt.formatoptions = 'l'
opt.formatoptions = opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore
