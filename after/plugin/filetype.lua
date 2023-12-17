vim.cmd([[
  augroup filetypedetect
    autocmd! BufRead,BufNewFile .swcrc       setfiletype json
    autocmd! BufRead,BufNewFile .prettierrc  setfiletype json
  augroup END
]])
