return {
  'zbirenbaum/copilot.lua',
  config = function()
    require('copilot').setup {}
    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuOpen',
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })
  end,
}
