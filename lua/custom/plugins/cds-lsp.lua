vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').cds = {
      install_info = {
        url = 'https://github.com/cap-js-community/tree-sitter-cds.git',
        revision = 'HEAD',
        queries = 'queries', -- also install queries from given directory
      },
      filetype = 'cds',
      -- additional filetypes that use this parser
      used_by = { 'cdl', 'hdbcds' },
    }
  end,
})

vim.pack.add {
  {
    src = 'https://github.com/neovim/nvim-lspconfig',
    servers = {
      cds_lsp = {
        cmd = {
          vim.fn.expand 'cds-lsp',
          '--stdio',
        },
        filetypes = { 'cds' },
      },
    },
  },
}
