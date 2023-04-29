-- mgua: here are my additional keymaps

-- .o. / .wo. ecc are the "scopes"
-- .o. is the general settings
-- .wo. are the windows scoped options
-- .bo. are the buffer scope
-- see https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
vim.cmd [[
	set cc=90			" column where to put vertical bar
	set shiftwidth=4
	set tabstop=4
	set scrolloff=4 	" never allow curson closer than 4 lines from upper/bottom borders
	set encoding=UTF-8	" default encoding
	set nowrap!
	set list
	"next two lines are the same: in unicode and in equivalente representations
	"set listchars=eol:⏎,tab:▸·,trail:·,space:·,nbsp:⎵	" center dot: alt-250
	"set listchars=eol:\\u23ce,tab:\\u25b8\\u2500,trail:\\u00b7,space:\\u00b7,nbsp:\\u23b5

	" alter the following line to adjust to your setup
	"let g:python3_host_prog='~/venv_nvim/bin/python'						" linux
	let g:python3_host_prog='c:\Users\mgua0\venv_nvim\Scripts\python.exe'	" windows

]]
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.listchars = { eol = '↲', tab = '▸-', trail = '·', space = '·', nbsp = '_' }
--vim.opt.listchars = {eol = '\\u23ce', tab = '\\u25b8\\u2500', trail = '\\u00b7', space = '\\u00b7', nbsp = '\\u23b5'}

-- i want to make <leader>tt to toggle nvtree
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<Enter>")
-- vim.keymap.set("n", "<leader>r", ":%s/<C-r><C-w>//g<Left><Left>")
vim.keymap.set("n", "<C-Left>", "<C-w>gT")    -- go to previous tab
vim.keymap.set("n", "<C-Right>", "<C-w>gt")   -- go to next tab
vim.keymap.set("n", "<C-Up>", ":bprev<CR>")   -- change current tab to previous buffer
vim.keymap.set("n", "<C-Down>", ":bnext<CR>") -- change current tab to next buffer

return {}
