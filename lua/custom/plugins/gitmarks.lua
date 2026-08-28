local plugin_path = vim.fn.expand '~/Projects/Personal/gitmarks'

vim.opt.rtp:prepend(plugin_path)

local gitmarks = require 'gitmarks'

gitmarks.setup {
  width = 100,
}

vim.keymap.set('n', '<leader>g', '<Nop>', {
  desc = '[G]itmarks',
})

vim.keymap.set('n', '<leader>gh', function() gitmarks.hello() end, {
  desc = 'Hello from gitmarks',
})
