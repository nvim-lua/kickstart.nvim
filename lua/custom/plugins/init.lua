-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
vim.cmd [[au VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkon0-blinkon0-blinkon0-Cursor/lCursor
  \,sm:block-blinkon0-blinkon0-blinkon0
au VimLeave,VimSuspend * set guicursor=a:hor50-blinkon0]]
-- See the kickstart.nvim README for more information
return {}
