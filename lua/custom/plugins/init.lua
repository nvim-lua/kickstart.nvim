-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.number = true

vim.opt.relativenumber = true
vim.opt.wrap = false

vim.keymap.set('n', '<C-k>', '15k', { desc = 'Scroll up and center' })
vim.keymap.set('n', '<C-j>', '15j', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-c>', 'ggVGy', { desc = 'Copy file' })
vim.keymap.set('n', '<leader>e', ':Neotree<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>e', ':Explore<CR>', { desc = 'Open explorer' })

return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'sindrets/diffview.nvim',
      'ibhagwan/fzf-lua',
    },
    config = function()
      local neogit = require 'neogit'
      vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open Neogit' })
      neogit.setup {}
    end,
  },
  {
    'github/copilot.vim',
    cmd = 'Copilot', -- Load Copilot only when the 'Copilot' command is invoked
    event = 'InsertEnter', -- Load Copilot when entering insert mode
    config = true, -- Automatically run the default setup
  },
}
