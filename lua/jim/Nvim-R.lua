-- [[ Nvim-R ]]
--  NOTES
--  - Nvim-R will detect *.R, *.Rmd, *.qmd files on its own
--    These are 3 distinct file types
--    REF:  https://github.com/jalvesaq/Nvim-R/issues/724
--  - "The pattern to recognize chunks of R code in Rmd files is hardcoded in Nvim-R/ftplugin/rmd_nvimr.vim, Nvim-R/R/start_r.vim, R-Vim-runtime/syntax/rmd.vim, and R-Vim-runtime/indent/rmd.vim"
--  - ~/.local/share/nvim/lazy/Nvim-R/
--
vim.cmd([[ let R_args= ['--no-save', '--quiet'] ]]) -- minimize startup
vim.cmd([[ let R_assign=2 ]])                       -- underline becomes left arrow
vim.cmd([[ let R_enable_comment=1 ]])               -- toggle comments with xx


vim.cmd([[let g:LanguageClient_serverCommands = {
      \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
      \ }
  ]])

vim.cmd([[
  "  autocmd FileType r x :RStop<CR>
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
