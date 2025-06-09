-- Comment.nvim - Smart and powerful commenting plugin
-- https://github.com/numToStr/Comment.nvim

return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    require('Comment').setup({
      -- Add a space between comment and the line
      padding = true,
      -- Whether cursor should stay at its position
      sticky = true,
      -- LHS of toggle mappings in NORMAL mode
      toggler = {
        -- Line-comment toggle keymap
        line = 'gcc',
        -- Block-comment toggle keymap
        block = 'gbc',
      },
      -- LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        -- Line-comment keymap
        line = 'gc',
        -- Block-comment keymap
        block = 'gb',
      },
      -- LHS of extra mappings
      extra = {
        -- Add comment on the line above
        above = 'gcO',
        -- Add comment on the line below
        below = 'gco',
        -- Add comment at the end of line
        eol = 'gcA',
      },
      -- Enable keybindings
      mappings = {
        -- Operator-pending mapping
        basic = true,
        -- Extra mapping
        extra = true,
      },
      -- Pre-hook, called before commenting the line
      -- Can be used with treesitter for better tsx/jsx commenting
      pre_hook = nil,
      -- Post-hook, called after commenting is done
      post_hook = nil,
    })
  end,
}
