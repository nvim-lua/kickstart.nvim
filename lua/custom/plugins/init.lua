-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  vim.keymap.set('n', '<leader>sm', function()
    require('telescope.builtin').live_grep { search_dirs = { '/home/ccs/missbrenner/Documents/ns-3/ns3-mmwave-iab/src/mmwave/' } }
  end, { desc = '[S]earch [M]mwave files' }),
}
