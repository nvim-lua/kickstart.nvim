vim.opt.relativenumber = true

vim.o.undodir = os.getenv("HOME") .. "/.neovim/undodir"

-- TODO check if needed
vim.o.incsearch = true

vim.o.swapfile = false
vim.o.backup = false

vim.o.colorcolumn = "120" -- sets the separator bar

vim.o.errorbells = false

vim.o.cursorline = true

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.g.wiki_root = "~/wiki"
vim.cmd [[
  let g:wiki_journal_index = {
          \ 'link_text_parser': { b, d, p -> d },
          \ 'link_url_parser': { b, d, p -> 'journal/' . d }
          \}
]]

vim.o.guicursor = "a:blinkon0"

vim.g.copilot_no_tab_map = true
