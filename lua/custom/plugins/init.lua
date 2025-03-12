-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
-- When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again.
vim.opt.autoread = true

return {
  vim.keymap.set('n', '<leader>sm', function()
    require('telescope.builtin').live_grep { search_dirs = { '/home/ccs/missbrenner/Documents/ns-3/ns3-mmwave-iab/src/mmwave/' } }
  end, { desc = '[S]earch [M]mwave File Contents' }),
}
