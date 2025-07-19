-- VSCode Neovim plugin management

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- NOTE: for windows we need to make sure we're pointing towards the
--       correct path
if vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 then
  package.path = "%localappdata%\\nvim-data\\" .. package.path
  lazypath = vim.fn.stdpath 'data' .. '\\lazy\\lazy.nvim'
  -- lazypath ='C:\\Program Files\\Neovim\\bin\\lua' .. '\\lazy\\lazy.nvim'
  -- print('C:\\Program Files\\Neovim\\bin\\lua')
end

-- If lazy.nvim doesn't exist, clone it
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Lazy
require('lazy').setup({
  spec = {
    { -- Collection of various small independent plugins/modules
      'echasnovski/mini.nvim',
      config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]an [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 500 }

        -- Add/delete/replace surroundings (bracets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup()

        -- For more Mini.nvim stuff:
        --  Check out: https://github.com/echasnovski/mini.nvim
      end,
    }
  },
})