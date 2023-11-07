return {
  -- LSP Configuration & Plugin
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      opts = {}
    },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
}
--       These are some example plugins that I've included in the kickstart repository.
