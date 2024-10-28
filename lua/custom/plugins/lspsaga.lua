return {
  'nvimdev/lspsaga.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    -- Setup lspsaga with your custom settings
    require('lspsaga').setup {
      use_saga_diagnostic_sign = true,
      error_sign = 'E',
      warn_sign = 'W',
      hint_sign = 'H',
      infor_sign = 'I',
      code_action_icon = '💡',
      finder_action_keys = {
        open = 'o',
        vsplit = 's',
        split = 'i',
        quit = 'q',
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
      },
      code_action_keys = {
        quit = 'q',
        exec = '<CR>',
      },
      rename_action_quit = '<C-c>',
      definition_preview_icon = '🔍',
      border_style = 'round',
      rename_prompt_prefix = '➤',
    }

    -- Add custom key mappings for lspsaga
    local opts = { noremap = true, silent = true }

    -- Key mappings for lspsaga actions
    vim.api.nvim_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', opts) -- Code action
    vim.api.nvim_set_keymap('n', '<leader>rn', ':Lspsaga rename<CR>', opts) -- Rename
    vim.api.nvim_set_keymap('n', 'gh', ':Lspsaga hover_doc<CR>', opts) -- Hover doc
    vim.api.nvim_set_keymap('n', 'gd', ':Lspsaga lsp_finder<CR>', opts) -- LSP finder
    vim.api.nvim_set_keymap('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>', opts) -- Previous diagnostic
    vim.api.nvim_set_keymap('n', ']e', ':Lspsaga diagnostic_jump_next<CR>', opts) -- Next diagnostic
  end,
}
