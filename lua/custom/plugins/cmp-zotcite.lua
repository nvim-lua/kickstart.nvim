return {
  -- add blink.compat
  {
    'saghen/blink.compat',
    -- use the latest release
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      -- add the zotcite source
      { 'jalvesaq/cmp-zotcite' },
      -- zotcite is also needed
      { 'jalvesaq/zotcite' },
    },
    sources = {
      -- remember to enable your providers here
      default = { 'lsp', 'path', 'snippets', 'buffer', 'cmp_zotcite' },
      providers = {
        -- create provider
        cmp_zotcite = {
          -- IMPORTANT: use the same name as you would for nvim-cmp
          name = 'cmp_zotcite',
          module = 'blink.compat.source',

          -- all blink.cmp source config options work as normal:
          score_offset = -3,

          -- options specific to cmp-zotcite if needed
          opts = {},
        },
      },
    },
  },
}
