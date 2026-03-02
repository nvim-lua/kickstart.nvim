return {
  'antosha417/nvim-lsp-file-operations',
  dependencies = { 'nvim-neo-tree/neo-tree.nvim' },
  config = function()
    require('lsp-file-operations').setup()

    -- Advertise file operation capabilities to all LSP servers
    local file_ops_caps = require('lsp-file-operations').default_capabilities()
    vim.lsp.config('*', {
      capabilities = file_ops_caps,
    })
  end,
}
