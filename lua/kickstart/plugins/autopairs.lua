-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    local Rule = require 'nvim-autopairs.rule'
    local npairs = require 'nvim-autopairs'

    npairs.add_rules {
      -- Rule('$$', '$$', 'tex'),
      Rule('$', '$', 'tex'),
      Rule('\\(', '\\)', 'tex'),
    }
  end,
}
