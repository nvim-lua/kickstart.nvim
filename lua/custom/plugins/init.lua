-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'github/copilot.vim',
    event = 'VimEnter',
    config = function()
      vim.cmd 'Copilot setup'
    end,
  },
  {
    'sbdchd/neoformat',
    cmd = 'Neoformat',
    config = function()
      vim.g.neoformat_enabled_javascript = { 'prettier' }
      vim.g.neoformat_enabled_python = { 'black' }
      vim.g.neoformat_enabled_typescript = { 'prettier' }
      vim.g.neoformat_enabled_yaml = { 'prettier' }
      vim.g.neoformat_run_on_save = 1
    end,
  },
}
