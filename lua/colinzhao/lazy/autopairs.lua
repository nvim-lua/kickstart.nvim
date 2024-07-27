return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require 'nvim-autopairs'

    npairs.setup {
      fast_wrap = {},
    }

    -- change default fast_wrap
    npairs.setup {
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'", '`' },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        before_key = 'h',
        after_key = 'l',
        cursor_pos_before = true,
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        manual_position = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
    }
  end,
  opts = {
    --ignored_next_char = '[^;:.,=}%])>` %n%t]',
    --enable_check_bracket_line = false,
  },
  -- use opts = {} for passing setup options
  -- this is equalent to setup({}) function
}
