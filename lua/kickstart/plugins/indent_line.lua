return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
    config = function()
      require('ibl').setup({
        exclude = {
          buftypes = {'NvimTree', 'terminal', 'term', 'dashboard', 'gitcommit', 'fugitive'},
          filetypes = {'NvimTree', 'terminal', 'term', 'dashboard', 'gitcommit', 'fugitive'}
        },
      -- context_patterns = {'class', 'function', 'method', 'block', 'list_literal', 'selector', '^if', '^table', 'if_statement', 'while', 'for', 'object', 'start_tag', 'open_tag', 'element'},
      -- show_first_indent_level = true,
      -- show_trailing_blankline_indent = false,
      })
    end,
  },
}
