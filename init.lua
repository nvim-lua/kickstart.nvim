local config_path = vim.fn.stdpath 'config'
package.path = config_path .. '/?.lua;' .. config_path .. '/?/init.lua;' .. package.path

require 'core.keymaps'
require 'options.autocmds'
require 'options.settings'
-- require 'plugins.init'

local plugins = require 'plugins'

-- Set leader key before lazy.nvim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ plugins }, {
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

-- Set up swap file directory to be in a central location
vim.opt.directory = vim.fn.stdpath('data') .. '/swapfiles/'

-- Create the swap directory if it doesn't exist
local swap_dir = vim.fn.stdpath('data') .. '/swapfiles'
if vim.fn.isdirectory(swap_dir) == 0 then
  vim.fn.mkdir(swap_dir, 'p')
end

-- Configure swap file behavior
vim.opt.swapfile = true  -- Keep swap files for recovery
vim.opt.updatetime = 300 -- Save swap file after 300ms of inactivity
vim.opt.updatecount = 100 -- Write to swap file after 100 characters

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
