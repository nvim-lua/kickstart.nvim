return {
  'weygoldt/rose-pine-neovim',
  -- 'rose-pine/neovim',
  name = 'rose-pine',
  priority = 100,
  config = function()
    vim.cmd.colorscheme 'rose-pine'
  end,
}
