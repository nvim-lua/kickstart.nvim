return {
  'preservim/nerdtree',
  version = '*',
  dependencies = {
    'ryanoasis/vim-devicons',
  },
  keys = {
    { '<leader>n', '<cmd>NERDTreeToggle<cr>' },
  },
  init = function()
    vim.g.NERDTreeShowLineNumbers = 1
  end,
}
