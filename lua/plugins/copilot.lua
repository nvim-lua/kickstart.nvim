return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        keymap = {
          accept = '<Tab>',
          next = '<S-Tab>',
        },
      },
    }
    require('copilot.suggestion').toggle_auto_trigger()
  end,
}
