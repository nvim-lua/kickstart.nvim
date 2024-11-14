return {
  'nvim-pack/nvim-spectre',
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>Sr', '<cmd>lua require("spectre").toggle()<CR>', {
      desc = 'Toggle Spectre',
    })

    keymap.set('n', '<leader>Sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
      desc = 'Search current word',
    })

    keymap.set('v', '<leader>Sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
      desc = 'Search current word',
    })

    keymap.set('n', '<leader>Sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
      desc = 'Search on current file',
    })
  end,
}
