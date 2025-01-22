-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'CRAG666/code_runner.nvim', config = true },
  { 'mbbill/undotree' },
  vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle, { desc = 'UndoTree' }),
}
