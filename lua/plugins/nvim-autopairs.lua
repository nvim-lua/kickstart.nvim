return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",  -- Only load in insert mode
  opts = {
    check_ts = true,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
      java = false,
    },
    ignored_next_char = "[%w%.]",
    enable_moveright = false,  -- Don't move cursor after pair
    enable_afterquote = false,  -- Don't add pairs after quotes
    enable_check_bracket_line = true,
    enable_bracket_in_quote = false,
    map_cr = true,
    map_bs = true,
    map_c_h = false,
    map_c_w = false,
    disable_in_macro = true,
    disable_in_visualblock = true,
    enable_abbr = false,
  },
  config = function(_, opts)
    local npairs = require('nvim-autopairs')
    npairs.setup(opts)

    -- Only enable completion integration if cmp is loaded
    local ok, cmp = pcall(require, 'cmp')
    if ok then
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  end,
}
