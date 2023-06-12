-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

function load_plugin (name)
  return require('custom.plugins.' .. name)
end

return {
  'nvim-tree/nvim-web-devicons',
  'preservim/nerdtree',

  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lua',
  'jose-elias-alvarez/null-ls.nvim',
  'simrat39/rust-tools.nvim',
  -- 'jose-elias-alvarez/nvim-lsp-ts-utils',
  {
    'p00f/clangd_extensions.nvim',
    lazy = false,
  },

  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',

  'RRethy/vim-illuminate',
  'ray-x/lsp_signature.nvim',
  'nvim-treesitter/nvim-treesitter-context',


  load_plugin('discord_presence'),

  load_plugin('oil'),
  load_plugin('bufferline'),
  load_plugin('terminal'),
  load_plugin('autopairs'),
  load_plugin('dashboard'),
  load_plugin('todocomment'),
  load_plugin('notify'),
  load_plugin('cursorword'),
  load_plugin('cursorline'),
  load_plugin('transparent'),
  load_plugin('fold'),
  load_plugin('colorpicker'),
  load_plugin('color_highlight'),
}

