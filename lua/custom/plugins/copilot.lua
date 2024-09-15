return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    suggestion = {
      auto_trigger = true,
      filetypes = {
        ['.'] = true,
      },
      keymap = {
        accept_word = '<M-k>',
        accept_line = '<M-j>',
        next = 'M-[',
        previous = 'M-]',
      },
    },
  },
}
