-- Ensure .cds files receive the correct filetype.
vim.filetype.add {
  extension = {
    cds = 'cds',
    cdl = 'cdl',
    hdbcds = 'hdbcds',
  },
}

-- Register the custom parser before TSInstall/TSUpdate runs.
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    vim.bo.commentstring = '// %s'
    require('nvim-treesitter.parsers').cds = {
      install_info = {
        url = 'https://github.com/cap-js-community/tree-sitter-cds.git',
        queries = 'queries',
      },
      filetype = 'cds',
    }
  end,
})

-- Associate all relevant filetypes with the CDS parser.
vim.treesitter.language.register('cds', {
  'cds',
  'cdl',
  'hdbcds',
})

-- Start Tree-sitter highlighting when one of these buffers opens.
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'cds',
    'cdl',
    'hdbcds',
  },
  callback = function(args)
    vim.treesitter.start(args.buf, 'cds')
  end,
})

-- Install nvim-lspconfig.
vim.pack.add {
  {
    src = 'https://github.com/neovim/nvim-lspconfig',
  },
}

-- Configure and enable cds-lsp separately.
vim.lsp.config('cds_lsp', {
  cmd = { 'cds-lsp', '--stdio' },
  filetypes = {
    'cds',
    'cdl',
    'hdbcds',
  },
  root_markers = {
    'package.json',
    '.git',
  },
})

vim.lsp.enable('cds_lsp')

-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'TSUpdate',
--   callback = function()
--     require('nvim-treesitter.parsers').cds = {
--       install_info = {
--         url = 'https://github.com/cap-js-community/tree-sitter-cds.git',
--         queries = 'queries', -- also install queries from given directory
--       },
--       filetype = 'cds',
--       -- additional filetypes that use this parser
--       used_by = { 'cdl', 'hdbcds' },
--     }
--   end,
-- })
--
-- vim.pack.add {
--   {
--     src = 'https://github.com/neovim/nvim-lspconfig',
--     servers = {
--       cds_lsp = {
--         cmd = {
--           vim.fn.expand 'cds-lsp',
--           '--stdio',
--         },
--         filetypes = { 'cds' },
--       },
--     },
--   },
-- }
