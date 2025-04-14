return {
	"akinsho/toggleterm.nvim",
	version = "*",
	-- config = true,
	opts = {
		shade_terminals = false,
	}
	-- set_terminal_keymaps = function()
	--   local opts = {buffer = 0}
	--   vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
	--   vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
	--   vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
	--   vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
	--   vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
	--   vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
	--   vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
	-- end
	--
	-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
	-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
}
