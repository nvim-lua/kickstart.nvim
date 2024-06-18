return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Highlighter
      require('mini.hipatterns').setup {
        highlighters = {
          -- Highlight standalone (`#rrggbb`) using that color
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
          hex_short_color = {
            pattern = '#%x%x%x%f[%X]',
            group = function(_, _, data)
              local match = data.full_match
              local correct = '#' .. string.rep(match:sub(2, 2), 2) .. string.rep(match:sub(3, 3), 2) .. string.rep(match:sub(4, 4), 2)
              return MiniHipatterns.compute_hex_color_group(correct, 'bg')
            end,
          },
          rgb = {
            pattern = '()Rgb%(%s*%d+,%s*%d+,%s*%d+%s*%)()',
            group = function(_, _, data)
              local _, _, r, g, b = data.full_match:find 'Rgb%(%s*(%d+),%s*(%d+),%s*(%d+)%s*%)'
              local correct = string.format('#%02x%02x%02x', r, g, b)
              if correct:len() ~= 7 then
                return
              end
              return MiniHipatterns.compute_hex_color_group(correct, 'bg')
            end,
            extmark_opts = {
              priority = 210,
            },
          },
        },
      }

      -- Move selected lines
      require('mini.move').setup {
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<M-Left>',
          right = '<M-Right>',
          down = '<M-Down>',
          up = '<M-Up>',

          -- Move current line in Normal mode
          line_left = '<M-Left>',
          line_right = '<M-Right>',
          line_down = '<M-Down>',
          line_up = '<M-Up>',
        },

        options = {
          reindent_linewise = true,
        },
      }
    end,
  },
}
