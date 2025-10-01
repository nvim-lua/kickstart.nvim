return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = '<M-l>',
          },
        },
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        filetypes = {
          ['*'] = true,
          typescript = true,
        },
      }
    end,
  },
}
