vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.title = true
vim.opt.clipboard = 'unnamedplus'
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

-- Enable folding in Neovim
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99 -- Keep folds open by default
vim.opt.foldcolumn = '1' -- Show fold column left of line numbers

vim.opt.foldtext = 'v:lua.custom_foldtext()' -- Custom fold text function

-- Function to change fold symbols
function _G.custom_foldtext()
  local line = vim.fn.getline(vim.v.foldstart) -- Get the first line of the fold
  local fold_size = vim.v.foldend - vim.v.foldstart + 1
  return line .. ' (' .. fold_size .. ' lines) ' -- Display fold size
end

-- Customize fold markers in fold column
vim.opt.statuscolumn = '%C' -- Customize fold column symbols
vim.opt.fillchars:append {
  foldopen = '▾', -- Down arrow for open folds
  foldclose = '▸', -- Right arrow for closed folds
  foldsep = ' ', -- Space between folds
  fold = ' ', -- Empty space for better visuals
}
