return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    local opts = { noremap = true, silent = true }
    -- Lua
    vim.keymap.set({ 'n', 't' }, '<A-o>', function()
      require('trouble').toggle()
    end, opts)

    vim.keymap.set('n', '<leader>ux', function()
      require('trouble').toggle()
    end, vim.tbl_extend('force', opts, { desc = '[X] Toggle trouble' }))

    vim.keymap.set('n', '<leader>uw', function()
      require('trouble').toggle 'workspace_diagnostics'
    end, vim.tbl_extend('force', opts, { desc = '[W]orkspace diagnostics' }))

    vim.keymap.set('n', '<leader>ud', function()
      require('trouble').toggle 'document_diagnostics'
    end, vim.tbl_extend('force', opts, { desc = '[D]ocument diagnostics' }))

    vim.keymap.set('n', '<leader>uq', function()
      require('trouble').toggle 'quickfix'
    end, vim.tbl_extend('force', opts, { desc = '[Q]uickfix' }))

    vim.keymap.set('n', '<leader>ul', function()
      require('trouble').toggle 'loclist'
    end, vim.tbl_extend('force', opts, { desc = '[L]oclist' }))

    vim.keymap.set('n', 'gR', function()
      require('trouble').open 'lsp_references'
    end, vim.tbl_extend('force', opts, { desc = '[R]eferences' }))
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
