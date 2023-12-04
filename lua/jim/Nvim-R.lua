-- [[ Nvim-R ]]
vim.cmd([[ let R_args= ['--no-save', '--quiet'] ]]) -- minimize startup
vim.cmd([[ let R_assign=2 ]])                       -- underline becomes left arrow
vim.cmd([[ let R_enable_comment=1 ]])               -- toggle comments with xx

-- seems to work
-- vim.cmd([[ let R_filetypes = ['r', 'rmd', 'rrst', 'rnoweb', 'quarto', 'rhelp'] ]])
vim.cmd([[let g:LanguageClient_serverCommands = {
    \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
    \ }
]])

vim.cmd([[
"  autocmd FileType r x :RStop<CR>
]])

vim.cmd([[
"   autocmd BufRead, BufNewFile *.r *.qmd *.rmd setlocal filetype = r
  ]])
vim.cmd([[
function! s:customNvimRMappings()
          nmap <buffer> <Leader>sr <Plug>RStart
"          imap <buffer> <Leader>sr <Plug>RStart
"          vmap <buffer> <Leader>sr <Plug>RStart
"          nnoremap <Leader>xxx ":call SendRmdChunkToR('echo', 'down')"
          nmap <buffer> <Leader>wwww  ":echo 'hi'<CR>"
       endfunction
       augroup myNvimR
          au!
          autocmd filetype r call s:customNvimRMappings()
       augroup end
]])
