-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}
    --
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- empty setup using defaults
    local nvim_tree_api = require 'nvim-tree.api'
    local function open_nvim_tree(data)
      -- buffer is a directory
      local directory = vim.fn.isdirectory(data.file) == 1
      if directory then
        -- change to the directory
        vim.cmd.cd(data.file)
        -- open the tree
        nvim_tree_api.tree.open()
        return
      end

      -- buffer is a real file on the disk
      local real_file = vim.fn.filereadable(data.file) == 1

      -- buffer is a [No Name]
      local no_name = data.file == '' and vim.bo[data.buf].buftype == ''

      if not real_file and not no_name then
        return
      end

      -- open the tree, find the file but don't focus it
      nvim_tree_api.tree.toggle { focus = false, find_file = true }
    end
    vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
    vim.keymap.set('n', '<leader>x', function()
      nvim_tree_api.tree.open()
    end)

    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('NvimTreeClose', { clear = true }),
      pattern = 'NvimTree_*',
      callback = function()
        local layout = vim.api.nvim_call_function('winlayout', {})
        if layout[1] == 'leaf' and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), 'filetype') == 'NvimTree' and layout[3] == nil then
          vim.cmd 'confirm quit'
        end
      end,
    })
  end,
}
