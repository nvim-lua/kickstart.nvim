-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup()

      vim.keymap.set('n', '<leader>tt', function()
        require('trouble').toggle()
      end)

      vim.keymap.set('n', '[t', function()
        require('trouble').next { skip_groups = true, jump = true }
      end)

      vim.keymap.set('n', ']t', function()
        require('trouble').previous { skip_groups = true, jump = true }
      end)
    end,
  },
  {
    'mbbill/undotree',

    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  },
  { 'akinsho/toggleterm.nvim', version = '*', opts = {
    open_mapping = [[<c-\>]],
  } },
}
