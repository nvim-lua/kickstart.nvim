return {
  'saghen/blink.cmp',
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
  },
  opts = {
    sources = {
      default = { "lsp", "path", "copilot", "buffer" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100, -- High priority to show Copilot near the top
          async = true,
        },
      },
    },
    keymap = {
      preset = 'default',
      accept = '<C-y>',  -- Your preferred accept key
    },
    appearance = {
      -- Show source of completion (LSP/Copilot/Buffer)
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    fuzzy = {},
  },
}
