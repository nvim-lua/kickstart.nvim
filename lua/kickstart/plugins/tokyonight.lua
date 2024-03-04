return { -- You can easily change to a different colorscheme.
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
  'folke/tokyonight.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- Load the colorscheme here
    vim.cmd.colorscheme 'tokyonight-night'
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'None' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'None' })
    vim.api.nvim_set_hl(0, 'Line', { bg = 'None' })

    -- You can configure highlights by doing something like
    vim.cmd.hi 'Comment gui=none'
  end,
}
