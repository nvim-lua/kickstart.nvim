-- Treesitter configuration override

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
        -- List ALL parsers you want installed based on your previous config
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
        'nix', -- Added based on previous diff
        'python', -- Added based on previous diff
        'query',
        'vim',
        'vimdoc',
        'yaml', -- Added based on previous diff
        -- Add any others you commonly use
      },
      -- Autoinstall languages that are not installed
      auto_install = true, -- Keep kickstart's default or set as desired

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
