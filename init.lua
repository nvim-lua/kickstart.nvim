-- ~/.config/nvim/init.lua
require 'core.options'  -- Load general options
require 'core.keymaps'  -- Load general keymaps
require 'core.snippets' -- Custom code snippets

-- Install package manager (lazy.nvim)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Filetypes
vim.filetype.add({
  extension = { templ = 'templ' },
})

-- Theme selection (robust against unknown NVIM_THEME)
local default_color_scheme = 'quantum'
local env_var_nvim_theme = os.getenv('NVIM_THEME') or default_color_scheme
local themes = {
  quantum = 'plugins.themes.quantum',
  nord    = 'plugins.themes.nord',
  onedark = 'plugins.themes.onedark',
}
local theme_module = themes[env_var_nvim_theme] or themes[default_color_scheme]

-- Plugins
require('lazy').setup({
  require(theme_module),
  require 'core.ui',
  -- Load mason early so tools are ready for LSP configs
  require 'plugins.mason',

  -- Core dev UX
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lualine',
  require 'plugins.bufferline',
  require 'plugins.indent-blankline',
  require 'plugins.neo-tree',
  require 'plugins.toggleterm',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.zellij',
  require 'plugins.flash',
  require 'plugins.comment',
  require 'plugins.harpoon',
  require 'plugins.gitsigns',
  require 'plugins.lazygit',
  require 'plugins.aerial',
  require 'plugins.misc',
  require 'plugins.snack',

  -- LSP & companions
  require 'plugins.autocompletion',
  require 'plugins.lsp',
  require 'plugins.none-ls',     -- none-ls/null-ls sources & setup
  require 'plugins.autoformat',  -- your autoformat-on-save/idle logic
  require 'plugins.conform',

  -- Debugging / DB (as you had)
  require 'plugins.debug',
  require 'plugins.database',

  require 'plugins.lsp-keymaps',
  require 'plugins.trouble',
  require 'plugins.spectre',

  -- TESTING
  require 'plugins.octo',
  require 'plugins.codecompanion',

}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘', config = '🛠', event = '📅', ft = '📂', init = '⚙',
      keys = '🗝', plugin = '🔌', runtime = '💻', require = '🌙',
      source = '📄', start = '🚀', task = '📌', lazy = '💤 ',
    },
  },
})

-- (Optional) tiny helper if you ever want to source a session file
local function file_exists(file)
  local f = io.open(file, 'r')
  if f then f:close(); return true end
  return false
end

-- local session_file = '.session.vim'
-- if file_exists(session_file) then vim.cmd('source ' .. session_file) end

-- vim: ts=2 sts=2 sw=2 et

