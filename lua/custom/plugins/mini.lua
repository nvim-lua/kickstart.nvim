return {
  'nvim-mini/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.move').setup()
    require('mini.git').setup()

    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return '%2l:%-2v' end

    vim.keymap.set('n', '<leader>ga', '<cmd>Git add -A<CR>', { desc = 'Git add all' })
    vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = 'Git commit' })
    vim.keymap.set('n', '<leader>gs', '<cmd>Git stash<CR>', { desc = 'Git stash' })
    vim.keymap.set('n', '<leader>gg', '<cmd>Git log --graph --oneline --all<CR>', { desc = 'Git graph' })
  end,
}
