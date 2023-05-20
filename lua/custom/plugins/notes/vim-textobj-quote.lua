return {
  'preservim/vim-textobj-quote',
  dependencies = { 'kana/vim-textobj-user' },
  config = function()
    vim.cmd [[
      augroup textobj_quote
        autocmd!
        autocmd FileType markdown call textobj#quote#init()
        autocmd FileType textile call textobj#quote#init()
        autocmd FileType text call textobj#quote#init({'educate': 0})
      augroup END
    ]]
  end,
  ft = { 'markdown', 'mkd', 'textile', 'tex', 'text' },
}
