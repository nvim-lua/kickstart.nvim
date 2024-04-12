-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  -- multi line
  { 'mg979/vim-visual-multi' },

  --tag bar to se files content on side pannel
  {
    'preservim/tagbar',
    config = function()
      vim.keymap.set({ 'n' }, '<leader>tt', '<cmd>Tagbar<CR>', { desc = '[T]oggle [T]agbar' })
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'markdown' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          width = 50,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }
      vim.keymap.set({ 'n' }, '<leader>st', ':NvimTreeFindFile<CR>', { desc = '[S]earch [T]ree' })
      vim.keymap.set({ 'n' }, 'xx', ':NvimTreeFindFileToggle<CR>', { desc = '[C]lose NvimTree' })
    end,
  },
}
