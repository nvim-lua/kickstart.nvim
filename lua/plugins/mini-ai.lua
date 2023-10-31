return {
  'echasnovski/mini.ai',
  -- keys = {
  --   { "a", mode = { "x", "o" } },
  --   { "i", mode = { "x", "o" } },
  -- },
  opts = function()
    local ai = require 'mini.ai'
    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }, {}),
        f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
        t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
      },
    }
  end,
}
