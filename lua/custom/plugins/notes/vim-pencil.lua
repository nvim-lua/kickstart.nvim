return {
  'preservim/vim-pencil',
  config = function()
    vim.cmd [[
      augroup pencil
        autocmd!
        autocmd FileType markdown,mkd call pencil#init()
        autocmd FileType text         call pencil#init()
      augroup END
    ]]
  end,
  ft = { 'markdown', 'mkd', 'textile', 'tex', 'text' },
}
