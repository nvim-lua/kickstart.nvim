-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {}
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

      ---@diagnostic disable-next-line: lowercase-global
      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
    end,
  },
}
