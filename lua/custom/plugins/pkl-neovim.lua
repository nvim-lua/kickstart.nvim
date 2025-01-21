if true then
  return {}
else
  return {
    'https://github.com/apple/pkl-neovim',
    lazy = true,
    event = 'BufReadPre *.pkl',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    build = function()
      vim.cmd 'TSInstall! pkl'
    end,
  }
end
