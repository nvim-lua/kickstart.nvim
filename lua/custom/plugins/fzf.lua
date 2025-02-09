return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function()
    local fzf = require 'fzf-lua'

    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]elect FZF' })
    vim.keymap.set('n', '<leader>sd', fzf.lsp_document_diagnostics, { desc = '[S]earch [D]iagnostics' })

    fzf.setup()
    fzf.register_ui_select()
  end,
}
