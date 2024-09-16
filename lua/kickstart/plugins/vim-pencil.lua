return {
  {
    'preservim/vim-pencil',
    opt = false,
    config = function()
      vim.g.tex_conceal = ''
      vim.g['pencil#conceallevel'] = 1
      vim.g['pencil#wrapModeDefault'] = 'soft'
    end,
  },
}
