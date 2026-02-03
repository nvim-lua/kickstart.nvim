local map = vim.keymap.set

----------------------------------------------------------------------
-- WINDOW MANAGEMENT (<leader>w)
----------------------------------------------------------------------
map('n', '<leader>w|', '<C-w>v', { desc = 'Split window right' })
map('n', '<leader>w-', '<C-w>s', { desc = 'Split window below' })
map('n', '<leader>wd', '<C-w>c', { desc = '[W]indow [D]elete' })
map('n', '<leader>wo', '<C-w>o', { desc = '[W]indow [O]nly (close others)' })
map('n', '<leader>wm', function()
  if vim.t.maximized then
    vim.cmd('wincmd =')
    vim.t.maximized = false
  else
    vim.cmd('wincmd _|')
    vim.t.maximized = true
  end
end, { desc = '[W]indow toggle [M]aximize' })
map('n', '<leader>w=', '<C-w>=', { desc = 'Equalize window sizes' })
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

----------------------------------------------------------------------
-- BUFFER MANAGEMENT (<leader>b)
----------------------------------------------------------------------
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = '[B]uffer [D]elete' })
map('n', '<leader>bD', '<cmd>bdelete!<cr>', { desc = '[B]uffer [D]elete (force)' })
map('n', '<leader>bo', function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = '[B]uffer delete [O]thers' })
map('n', '<leader>bb', '<cmd>b#<cr>', { desc = '[B]uffer [B]ack to alternate' })
map('n', '<leader>b1', '1gt', { desc = 'Go to tab 1' })
map('n', '<leader>b2', '2gt', { desc = 'Go to tab 2' })
map('n', '<leader>b3', '3gt', { desc = 'Go to tab 3' })
map('n', '<leader>b4', '4gt', { desc = 'Go to tab 4' })
map('n', '<leader>b5', '5gt', { desc = 'Go to tab 5' })
map('n', '<leader>b6', '6gt', { desc = 'Go to tab 6' })
map('n', '<leader>b7', '7gt', { desc = 'Go to tab 7' })
map('n', '<leader>b8', '8gt', { desc = 'Go to tab 8' })
map('n', '<leader>b9', '9gt', { desc = 'Go to tab 9' })
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })

----------------------------------------------------------------------
-- TAB MANAGEMENT (<leader><tab>)
----------------------------------------------------------------------
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First tab' })
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close other tabs' })
map('n', '<leader>1', '1gt', { desc = 'Go to tab 1' })
map('n', '<leader>2', '2gt', { desc = 'Go to tab 2' })
map('n', '<leader>3', '3gt', { desc = 'Go to tab 3' })
map('n', '<leader>4', '4gt', { desc = 'Go to tab 4' })
map('n', '<leader>5', '5gt', { desc = 'Go to tab 5' })
map('n', '<leader>6', '6gt', { desc = 'Go to tab 6' })
map('n', '<leader>7', '7gt', { desc = 'Go to tab 7' })
map('n', '<leader>8', '8gt', { desc = 'Go to tab 8' })
map('n', '<leader>9', '9gt', { desc = 'Go to tab 9' })

----------------------------------------------------------------------
-- TOGGLES (<leader>u)
----------------------------------------------------------------------
map('n', '<leader>ul', function() vim.wo.number = not vim.wo.number end, { desc = 'Toggle [L]ine numbers' })
map('n', '<leader>uL', function() vim.wo.relativenumber = not vim.wo.relativenumber end, { desc = 'Toggle relative line [L]numbers' })
map('n', '<leader>uw', function() vim.wo.wrap = not vim.wo.wrap end, { desc = 'Toggle [W]rap' })
map('n', '<leader>us', function() vim.wo.spell = not vim.wo.spell end, { desc = 'Toggle [S]pell' })
map('n', '<leader>uc', function()
  vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0
end, { desc = 'Toggle [C]onceal' })
map('n', '<leader>ub', function()
  vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
end, { desc = 'Toggle [B]ackground' })
map('n', '<leader>uS', function() vim.wo.list = not vim.wo.list end, { desc = 'Toggle [S]how whitespace' })
map('n', '<leader>uh', '<cmd>set hlsearch!<cr>', { desc = 'Toggle search [H]ighlight' })
map('n', '<leader>ud', function()
  local config = vim.diagnostic.config()
  vim.diagnostic.config({ virtual_text = not config.virtual_text })
end, { desc = 'Toggle [D]iagnostics' })
map('n', '<leader>ur', '<cmd>nohlsearch<cr><cmd>redraw<cr>', { desc = '[U]I [R]edraw / clear highlight' })

----------------------------------------------------------------------
-- GIT (<leader>g)
----------------------------------------------------------------------
map('n', '<leader>gb', function()
  local ok, gitsigns = pcall(require, 'gitsigns')
  if ok then
    gitsigns.blame_line({ full = true })
  else
    vim.cmd('Git blame')
  end
end, { desc = '[G]it [B]lame' })
map('n', '<leader>gl', function()
  vim.cmd('new')
  vim.cmd('terminal git log --oneline -20')
  vim.cmd('startinsert')
end, { desc = '[G]it [L]og' })
map('n', '<leader>gL', function()
  vim.cmd('new')
  vim.cmd('terminal git log --oneline -20 -- ' .. vim.fn.expand('%'))
  vim.cmd('startinsert')
end, { desc = '[G]it [L]og (current file)' })
map('n', '<leader>gg', function()
  vim.cmd('terminal lazygit')
  vim.cmd('startinsert')
end, { desc = '[G]it [G]ui (LazyGit)' })
map('n', '<leader>gS', '<cmd>Git<cr>', { desc = '[G]it [S]tatus' })
map('n', '<leader>gd', function() vim.cmd('Gvdiffsplit') end, { desc = '[G]it [D]iff' })

----------------------------------------------------------------------
-- QUICKFIX / LOCATION LIST (<leader>x)
----------------------------------------------------------------------
map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix list' })
map('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location list' })
map('n', '<leader>xc', '<cmd>cclose<cr>', { desc = 'Close quickfix' })
map('n', '<leader>xC', '<cmd>lclose<cr>', { desc = 'Close location list' })
map('n', ']q', '<cmd>cnext<cr>', { desc = 'Next quickfix item' })
map('n', '[q', '<cmd>cprevious<cr>', { desc = 'Previous quickfix item' })
map('n', ']Q', '<cmd>clast<cr>', { desc = 'Last quickfix item' })
map('n', '[Q', '<cmd>cfirst<cr>', { desc = 'First quickfix item' })
map('n', ']l', '<cmd>lnext<cr>', { desc = 'Next location item' })
map('n', '[l', '<cmd>lprevious<cr>', { desc = 'Previous location item' })

----------------------------------------------------------------------
-- LSP / CODE (<leader>c)
----------------------------------------------------------------------
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
map('x', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
map('n', '<leader>cr', vim.lsp.buf.rename, { desc = '[C]ode [R]ename' })
map('n', '<leader>cA', function()
  vim.lsp.buf.code_action({ context = { only = { 'source' } }, apply = true })
end, { desc = '[C]ode [A]ction (source)' })
map('n', '<leader>cl', '<cmd>LspInfo<cr>', { desc = '[C]ode [L]SP Info' })
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line [D]iagnostics' })
map('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Next [E]rror' })
map('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Previous [E]rror' })
map('n', ']w', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, { desc = 'Next [W]arning' })
map('n', '[w', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, { desc = 'Previous [W]arning' })

----------------------------------------------------------------------
-- UTILITIES
----------------------------------------------------------------------
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
map('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
map('n', 'J', 'mzJ`z', { desc = 'Join lines (keep position)' })
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move line down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move line up' })
map('v', '<A-j>', "<cmd>m '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('v', '<A-k>', "<cmd>m '<-2<cr>gv=gv", { desc = 'Move selection up' })
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = '[F]ile [N]ew' })
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[Q]uit [Q]all' })
map('n', '<leader>qQ', '<cmd>qa!<cr>', { desc = '[Q]uit [Q]all (force)' })
map('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Open [L]azy' })
map('n', '<leader>cf', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end, { desc = '[C]ode [F]ormat' })
map('x', '<leader>cf', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end, { desc = '[C]ode [F]ormat' })

----------------------------------------------------------------------
-- TERMINAL
----------------------------------------------------------------------
map('n', '<leader>ft', function()
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
end, { desc = '[F]ile [T]erminal' })
map('n', '<C-/>', function()
  vim.cmd('terminal')
  vim.cmd('startinsert')
end, { desc = 'Open terminal' })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Close terminal' })
map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Go to left window' })
map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Go to lower window' })
map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Go to upper window' })
map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Go to right window' })

return {}
