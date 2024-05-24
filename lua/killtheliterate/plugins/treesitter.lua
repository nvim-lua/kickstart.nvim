return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'css',
        'html',
        'javascript',
        'json',
        'lua',
        'python',
        'scss',
        'svelte',
        'tsx',
        'typescript',
        'vim',
      },
    }

    require('ts_context_commentstring').setup {
    }

    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }

    vim.g.skip_ts_context_commentstring_module = true
  end
}
