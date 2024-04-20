-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- multi line
  { 'mg979/vim-visual-multi' },

  {
    'windwp/nvim-ts-autotag',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'markdown' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  --tag bar to se files content on side pannel
  -- {
  --   'preservim/tagbar',
  --   config = function()
  --     vim.keymap.set({ 'n' }, '<leader>tt', '<cmd>Tagbar<CR>', { desc = '[T]oggle [T]agbar' })
  --   end,
  -- },
}
