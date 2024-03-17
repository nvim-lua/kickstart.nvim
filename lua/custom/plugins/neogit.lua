local M = {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
  },
  config = true,
}

-- filetype of neogit window: NeogitStatus

function M.config()
  local neogit = require('neogit')
  neogit.setup({})

  -- Keymaps
  vim.keymap.set('n', '<leader>gg', function()
    neogit.open({ kind = 'split_above' })
  end, { desc = 'neogit' })
end

return M
