return {
  'FabijanZulj/blame.nvim',
  config = function()
    local blame = require 'blame'
    blame.setup()

    vim.keymap.set('n', '<leader>gb', ':BlameToggle<CR>')
  end,
}
