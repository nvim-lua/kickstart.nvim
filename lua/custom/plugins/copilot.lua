return {
  'github/copilot.vim',
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      gitcommit = true,
      yaml = true,
      markdown = true,
      help = true,
    },
  },
  build = ':Copilot auth',
  config = function()
    -- vim.keymap.set('n', '<leader>pp', ':set invpaste<CR>', { noremap = true, desc = 'Co[p]ilot [P]aste' })
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
      ['gitcommit'] = {
        enable = true,
        -- Disable using previous commit messages as suggestions
        previous_commit_history = false
      }
    }
  end,
}
