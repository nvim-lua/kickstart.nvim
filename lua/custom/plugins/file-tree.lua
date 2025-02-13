-- 文件树
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- 不严格要求，但推荐
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup { close_if_last_window = true }
    vim.keymap.set('n', '<leader>tf', ':Neotree toggle<CR>', { desc = '[T]oggle [F]ileTree' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
