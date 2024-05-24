return {
  'phaazon/hop.nvim',
  cond = false,
  branch = 'v2',
  config = function()
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection

    hop.setup {}

    vim.keymap.set(
      '',
      '<leader>h',
      function() hop.hint_char1({ direction = directions.AFTER_CURSOR }) end,
      { remap = true, desc = '[H]opChar1 forwards' }
    )

    vim.keymap.set(
      '',
      '<leader>H',
      function() hop.hint_char1({ direction = directions.BEFORE_CURSOR }) end,
      { remap = true, desc = '[H]opChar1 backwards' }
    )
  end
}
