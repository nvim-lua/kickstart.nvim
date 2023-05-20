return {
  'preservim/vim-textobj-sentence',
  config = function()
    vim.cmd [[
      augroup textobj_sentence
        autocmd!
        autocmd FileType markdown call textobj#sentence#init()
        autocmd FileType textile call textobj#sentence#init()
      augroup END
    ]]
  end,
  ft = { 'markdown', 'mkd', 'textile', 'tex', 'text' },
}
