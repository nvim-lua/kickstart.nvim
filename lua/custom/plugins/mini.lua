return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.starter').setup()
    require('mini.files').setup()
    require('mini.comment').setup()

    vim.keymap.set('n', '<leader>e', function()
      MiniFiles.open(vim.api.nvim_buf_get_name(0))
    end, { desc = 'File [E]xplorer' })

    -- Simple and easy statusline
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
