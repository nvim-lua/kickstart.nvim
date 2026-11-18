local languages = {
  'bash',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'vim',
  'vimdoc',
  'go',
  'gomod',
  'gosum',
  'terraform',
  'dockerfile',
  'gitignore',
  'json',
  'rust',
}

return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath 'data' .. '/site',
      }
      require('nvim-treesitter').install(languages)

      -- Parser names differ from some filetype names (e.g. sh -> bash)
      local filetypes = vim.list_extend(vim.deepcopy(languages), { 'sh', 'help' })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
