return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<C-CR>', -- Ctrl+Enter (better for Mac)
        },
        layout = {
          position = 'bottom',
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<Tab>', -- Tab to accept (most common)
          accept_word = '<C-Right>', -- Ctrl+Right Arrow
          accept_line = '<C-l>', -- Ctrl+l
          next = '<A-]>', -- Ctrl+] for next
          prev = '<A-[>', -- Ctrl+[ for previous
          dismiss = '<C-\\>', -- Ctrl+\ to dismiss
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
      copilot_node_command = 'node', -- Make sure you have Node.js installed
      server_opts_overrides = {},
    }

    -- Mac-friendly custom keymaps
    local opts = { silent = true, noremap = true }

    -- Panel controls (using Cmd instead of Alt when possible)
    vim.keymap.set('n', '<leader>co', function()
      require('copilot.panel').open { position = 'bottom', ratio = 0.4 }
    end, { desc = 'Open Copilot panel' })

    vim.keymap.set('n', '<leader>cr', function()
      require('copilot.panel').refresh()
    end, { desc = 'Refresh Copilot suggestions' })

    vim.keymap.set('n', '<leader>cc', function()
      require('copilot.panel').close()
    end, { desc = 'Close Copilot panel' })

    -- Alternative panel opening in insert mode
    vim.keymap.set('i', '<C-g>', function()
      require('copilot.panel').open { position = 'right', ratio = 0.3 }
    end, { desc = 'Open Copilot panel (insert mode)' })

    -- Suggestion controls that work well on Mac
    vim.keymap.set('i', '<C-j>', function()
      require('copilot.suggestion').next()
    end, { desc = 'Next Copilot suggestion' })

    vim.keymap.set('i', '<C-k>', function()
      require('copilot.suggestion').prev()
    end, { desc = 'Previous Copilot suggestion' })

    -- Toggle auto trigger
    vim.keymap.set('i', '<C-o>', function()
      require('copilot.suggestion').toggle_auto_trigger()
    end, { desc = 'Toggle Copilot auto trigger' })

    -- Manual suggestion trigger
    vim.keymap.set('i', '<C-Space>', function()
      require('copilot.suggestion').next()
    end, { desc = 'Trigger Copilot suggestion' })

    -- Accept with different granularities
    vim.keymap.set('i', '<S-Tab>', function()
      require('copilot.suggestion').accept_word()
    end, { desc = 'Accept word' })

    vim.keymap.set('i', '<C-Tab>', function()
      require('copilot.suggestion').accept_line()
    end, { desc = 'Accept line' })
  end,
}
