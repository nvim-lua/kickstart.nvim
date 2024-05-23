-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    {
      'numToStr/Comment.nvim',
      opts = function()
        require('Comment').setup {
          ---Add a space b/w comment and the line
          padding = true,
          ---Whether the cursor should stay at its position
          sticky = true,
          ---Lines to be ignored while (un)comment
          ignore = '^$',
          ---LHS of toggle mappings in NORMAL mode
          toggler = {
            ---Line-comment toggle keymap
            line = 'gcc',
            ---Block-comment toggle keymap
            block = 'gbc',
          },
          ---LHS of operator-pending mappings in NORMAL and VISUAL mode
          opleader = {
            ---Line-comment keymap
            line = 'gc',
            ---Block-comment keymap
            block = 'gb',
          },
          ---LHS of extra mappings
          extra = {
            ---Add comment on the line above
            above = 'gcO',
            ---Add comment on the line below
            below = 'gco',
            ---Add comment at the end of line
            eol = 'gcA',
          },
          ---Enable keybindings
          --- NOTE: If given `false` then the plugin won't create any mappings
          mappings = {
            ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
            basic = true,
            ---Extra mapping; `gco`, `gcO`, `gcA`
            extra = true,
          },
          ---Function to call before (un)comment
          pre_hook = nil,
          ---Function to call after (un)comment
          post_hook = nil,
        }
        local ft = require 'Comment.ft'

        -- 1. Using set function

        ft
          -- Set only line comment
          .set('yaml', '#%s')
          -- Or set both line and block commentstring
          .set('javascript', { '//%s', '/*%s*/' })

        -- 2. Metatable magic

        ft.javascript = { '//%s', '/*%s*/' }
        ft.yaml = '#%s'

        -- Multiple filetypes
        ft({ 'go', 'rust' }, ft.get 'c')
        ft({ 'toml', 'graphql' }, '#%s')
      end,
      lazy = false,
    },
  },
}
