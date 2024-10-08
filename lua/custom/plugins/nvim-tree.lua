vim.keymap.set('n', '<leader>o', vim.cmd.NvimTreeOpen, { desc = '[Open] file tree' })
return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}
  end,
}
