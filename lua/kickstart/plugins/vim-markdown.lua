return {
  {
    'preservim/vim-markdown',
    dependencies = {
      'godlygeek/tabular',
    },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_toc_autofit = 1
      vim.g.vim_markdown_borderless_table = 1
    end,
  }
}
