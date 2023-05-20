return {
  'preservim/vim-lexical',
  config = function()
    vim.cmd [[
      augroup lexical
      autocmd!
      autocmd FileType markdown,mkd call lexical#init()
      autocmd FileType textile call lexical#init()
      autocmd FileType text call lexical#init({ 'spell': 0 })
      augroup END
      let g:lexical#spelllang = ['en_us','fr',]
    ]]
  end,
  ft = { 'markdown', 'mkd', 'textile', 'tex', 'text' },
}
