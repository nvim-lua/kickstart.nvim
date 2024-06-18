local map = vim.keymap.set

-- The good 'ol keybinds
map('n', '<C-s>', '<cmd>w<CR>', { noremap = true, silent = true, desc = 'File save' })
map('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'File copy whole' })

-- Move between windows with arrows
map('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Double Q to close current window
--map('n', 'qq', '<CMD>q<CR>', { silent = true, desc = 'CLose window' })
-- vim.api.nvim_create_autocmd('FileType', {
--  pattern = 'TelescopePrompt',
--  callback = function(params)
--    vim.keymap.set('', 'qq', '<Esc>', { noremap = true, buffer = params.buf })
--   end,
-- })

-- Keep cursor centered when PgUp & PgDown
map({ 'n', 'i', 'v' }, '<PageUp>', '<PageUp><CMD>normal zz<CR>', { desc = 'Page up' })
map({ 'n', 'i', 'v' }, '<PageDown>', '<PageDown><CMD>normal zz<CR>', { desc = 'Page down' })

-- Redirect command output and allow edit
map('c', '<S-CR>', function()
  require('noice').redirect(vim.fn.getcmdline())
end, { desc = 'Redirect Cmdline' })

-- LSP specific mappings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, fn, desc)
      vim.keymap.set('n', keys, fn, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local builtin = require 'telescope.builtin'
    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('gr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gi', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('gt', builtin.lsp_type_definitions, '[G]oto [T]ype Definition')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclarations')
    map('gic', builtin.lsp_incoming_calls, '[G]oto [I]ncoming [C]alls')
    map('goc', builtin.lsp_outgoing_calls, '[G]oto [O]utgoing [C]alls')
  end,
})
