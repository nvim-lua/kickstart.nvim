-- Correct clipboard configuration (this was the main issue)
vim.opt.clipboard:append 'unnamedplus' -- Use system clipboard for all operations

-- Remove this line (it's not doing anything useful)
-- vim.g.have_nerd_font = true  -- This is a custom variable not used in your config

-- Rest of your configuration with some optimizations:
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.title = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.formatoptions:append { 'r' }

-- Improved folding configuration
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldcolumn = '1'

-- Custom fold text function (simplified)
function _G.custom_foldtext()
  local line = vim.trim(vim.fn.getline(vim.v.foldstart))
  local fold_size = vim.v.foldend - vim.v.foldstart + 1
  return string.format('⏷ %s ⏤ %d lines ⏵', line, fold_size)
end

vim.opt.foldtext = 'v:lua.custom_foldtext()'

-- Better fold characters configuration
vim.opt.fillchars:append {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
}
