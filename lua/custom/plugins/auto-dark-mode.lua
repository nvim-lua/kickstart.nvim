return {
  'f-person/auto-dark-mode.nvim',
  event = 'VimEnter',  -- Lazy load on VimEnter event
  opts = {
    update_interval = 1000,  -- Check for mode change every second
    set_dark_mode = function()
      vim.cmd('colorscheme monokai')
      vim.cmd('set background=dark')  -- Ensure the background is set correctly
    end,
    set_light_mode = function()
      vim.cmd('colorscheme solarized')
      vim.cmd('set background=light')
    end,
  },
  config = function(_, opts)
    require('auto-dark-mode').setup(opts)
  end
}

