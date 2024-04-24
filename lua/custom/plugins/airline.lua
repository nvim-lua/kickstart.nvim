return {
  'vim-airline/vim-airline',
  dependencies = {
    'vim-airline/vim-airline-themes',
  },
  init = function()
    vim.g.airline_powerline_fonts = 1
    -- vim.g.airline_theme = 'bubblegum'
    vim.g.airline_theme = 'base16_gruvbox_dark_soft'
  end, -- Lazy load the configuration when vim-airline is loaded
}
