-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	-- NOTE: Yes, you can install new plugins here!
	'romgrk/barbar.nvim',
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- Move to previous/next
		map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
		map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
		-- Re-order to previous/next
		map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
		map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
		-- Goto buffer in position...
		map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
		map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
		map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
		map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
		map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
		map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
		map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
		map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
		map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
		map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
		-- Pin/unpin buffer
		map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
		-- Close buffer
		map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
		-- Wipeout buffer
		--                 :BufferWipeout
		-- Close commands
		--                 :BufferCloseAllButCurrent
		--                 :BufferCloseAllButPinned
		--                 :BufferCloseAllButCurrentOrPinned
		--                 :BufferCloseBuffersLeft
		--                 :BufferCloseBuffersRight
		-- Magic buffer-picking mode
		map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
		-- Sort automatically by...
		map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
		map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
		map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
		map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
	end,
}
