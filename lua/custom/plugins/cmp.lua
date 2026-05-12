-- blink.cmp: faster Rust-based completion (replaces nvim-cmp).
-- Provides LSP, path, snippet, and lazydev sources via single plugin.
return {
  'saghen/blink.cmp',
  version = '*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  opts = {
    -- Use the 'enter' preset: <CR> confirms, <Tab>/<S-Tab> cycle items.
    keymap = {
      preset = 'enter',
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = { border = 'rounded' },
    },
    signature = { enabled = true, window = { border = 'rounded' } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
  },
}
