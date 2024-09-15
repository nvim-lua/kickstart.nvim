return {
  'f-person/auto-dark-mode.nvim',
  opts = {
    update_interval = 2000,
    set_dark_mode = function()
      vim.api.nvim_set_option_value('background', 'dark', {})
      vim.cmd('colorscheme monokai')
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value('background', 'light', {})
      vim.cmd('colorscheme solarized')
    end,
  },
}
