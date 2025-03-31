return { -- FZF (Telescope replacement)
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { 'echasnovski/mini.icons' },
  opts = {},
  -- [[ fzf keybinds]]
  config = function()
    local fzf = require 'fzf-lua'
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch [W]ord' })
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Fuzzily search in current buffer' })
  end,
}
