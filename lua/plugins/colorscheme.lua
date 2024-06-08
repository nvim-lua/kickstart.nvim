-- return {
--   'folke/tokyonight.nvim',
--   priority = 1000,
--   init = function()
--     vim.cmd.colorscheme 'desert'
--     vim.cmd.hi 'Comment gui=none'
--   end,
-- }

return {
  'catppuccin/nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin-mocha'
    vim.cmd.hi 'Comment gui=none'
  end,
}
