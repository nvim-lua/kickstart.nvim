-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'TabbyML/vim-tabby',
    lazy = false,
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    init = function()
      vim.g.tabby_agent_start_command = { 'npx', 'tabby-agent', '--stdio' }
      vim.g.tabby_inline_completion_trigger = 'auto'
    end,
  },
}
