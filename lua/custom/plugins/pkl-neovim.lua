if true then
  return {}
end
return {
  'https://github.com/apple/pkl-neovim',
  lazy = true,
  event = 'BufReadPre *.pkl',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  build = function()
    vim.cmd 'TSInstall! pkl'
  end,
}
