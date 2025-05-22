return {
  -- ========================================
  -- Treesitter Configuration Override
  -- ========================================
  {
    'nvim-treesitter/nvim-treesitter',
    -- build = ':TSUpdate', -- Keep build command if needed from kickstart
    -- main = 'nvim-treesitter.configs', -- Keep if needed from kickstart
    opts = { -- Use opts to merge/override defaults
      ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'diff',
        'html',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'nix',
        'python',
        'query',
        'vim',
        'vimdoc',
        'yaml',
      },
      auto_install = true,

      -- Keep other kickstart defaults like highlight/indent settings unless you want to change them
      highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = { 'ruby' }, -- Keep if needed
      },
      indent = {
        enable = true,
        -- disable = { 'ruby' }, -- Keep if needed
      },
    },
    -- If kickstart used a config function for treesitter and you need to replicate
    -- parts of it that aren't handled by opts, add it here.
    -- config = function(_, opts)
    --   require('nvim-treesitter.configs').setup(opts)
    -- end,
  },
}
