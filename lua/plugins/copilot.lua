local COPILOT_ENABLED = false

vim.keymap.set('n', '<F8>', function()
  if COPILOT_ENABLED then
    vim.cmd 'Copilot disable'
    COPILOT_ENABLED = false
    print 'Copilot disabled'
  else
    vim.cmd 'Copilot enable'
    COPILOT_ENABLED = true
    print 'Copilot enabled'
  end
end, { noremap = true, silent = true })

return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    local copilot = require 'copilot'
    local suggestion = require 'copilot.suggestion'

    -- disable copilot by default
    copilot.setup {
      suggestion = {
        enabled = COPILOT_ENABLED,
        auto_trigger = true,
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
  end,
}
