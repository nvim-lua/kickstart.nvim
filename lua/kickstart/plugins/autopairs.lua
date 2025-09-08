-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true, -- use Treesitter for smart pairing
  },
  config = function(_, opts)
    local npairs = require 'nvim-autopairs'
    npairs.setup(opts)

    -- Add custom rule for < > in Rust
    local Rule = require 'nvim-autopairs.rule'

    npairs.add_rules {
      Rule('<', '>', 'rust'):with_pair(function(opts)
        local next_char = opts.line:sub(opts.col + 1, opts.col + 1)
        return next_char ~= '=' -- avoid pairing in things like <=
      end),
    }
  end,
}
