return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    local copilot = require 'copilot'
    local suggestion = require 'copilot.suggestion'

    copilot.setup {
      suggestion = {
        keymap = {
          accept = '<Tab>',
          next = '<S-Tab>',
        },
      },
    }

    -- Define the tab_complete function globally
    _G.tab_complete = function()
      if suggestion.is_visible() then
        vim.schedule(function()
          suggestion.accept()
        end)
      else
        return vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
      end
    end

    -- Map <Tab> to the global tab_complete function
    vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true, noremap = true, silent = true })

    suggestion.toggle_auto_trigger()
  end,
}
