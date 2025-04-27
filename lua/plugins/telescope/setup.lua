---@diagnostic disable: undefined-global
local M = {}

function M.setup()
  -- Base Telescope configuration
  require('telescope').setup {
    defaults = {
      mappings = {
        i = { ['<C-h>'] = 'which_key' },
        n = { ['?'] = 'which_key' },
      },
    },
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  -- Load extensions
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- Apply keymaps from core.keymaps
  local keymaps = require('core.keymaps').telescope_keymaps
  for _, mapping in ipairs(keymaps) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end

  -- Additional builtins mapping (if not handled by core)
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'LSP: [G]oto [R]eferences' })
  vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'LSP: [G]oto [D]efinition' })
  vim.keymap.set('n', 'gI', builtin.lsp_implementations, { desc = 'LSP: [G]oto [I]mplementation' })
  -- Other mappings moved from inline config
  vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
  end, { desc = '[/] Fuzzily search in current buffer' })
  vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
  end, { desc = '[S]earch [/] in Open Files' })
  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

return M
