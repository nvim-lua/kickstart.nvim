-- https://github.com/ray-x/lsp_signature.nvim
return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {
    toggle_key = '<C-g>',
  },
  config = function(_, opts)
    require('lsp_signature').setup(opts)

    vim.keymap.set('n', '<leader>cph', function()
      -- NOTE: For now, have to close it manually
      require('lsp_signature').toggle_float_win()
    end, { noremap = true, silent = true, desc = '[C]ode [P]arameter [H]elp' })
  end,
}
