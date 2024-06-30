local map = vim.keymap.set

-- The good 'ol keybinds
map('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
map('n', '<C-s>', '<cmd>w<CR>', { noremap = true, desc = 'File save' })
map('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'File copy whole' })

-- Activate Ctrl+V as paste
map('c', '<C-v>', function()
  local pos = vim.fn.getcmdpos()
  local text = vim.fn.getcmdline()
  local lt = text:sub(1, pos - 1)
  local rt = text:sub(pos)
  local clip = vim.fn.getreg '+'
  vim.fn.setcmdline(lt .. clip .. rt, pos + clip:len())
  vim.cmd [[echo '' | redraw]]
end, { silent = true, noremap = true, desc = 'Command paste' })
map({ 'i', 'n' }, '<C-v>', '"+p', { noremap = true, desc = 'Command paste' })

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
map('n', '<PgDown>', '<C-d><C-d>', { desc = 'Page down' })
map('n', '<PgUp>', '<C-u><C-u>', { desc = 'Page up' })
map('n', '<C-d>', '<C-d>zz', { desc = 'Half page down' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Half page up' })
map('n', 'n', 'nzzzv', { desc = 'so and so...' })
map('n', 'N', 'Nzzzv', { desc = 'so and so...' })

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

    vim.keymap.set({ 'n', 'i' }, '<A-k>', vim.lsp.buf.hover, { noremap = true })
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [C]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [C]hange' })
  end,
})
