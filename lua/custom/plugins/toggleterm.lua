---@diagnostic disable: lowercase-global
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {}
    local Terminal = require('toggleterm.terminal').Terminal

    local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }
    function _lazygit_toggle()
      lazygit:toggle()
    end
    vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true, desc = 'Toggle Lazygit' })

    local terminal = Terminal:new { hidden = true }
    function _terminal_toggle()
      terminal:toggle()
    end
    vim.api.nvim_set_keymap('n', '<leader>gt', '<cmd>lua _terminal_toggle()<CR>', { noremap = true, silent = true, desc = 'Toggle Terminal' })
  end,
}
