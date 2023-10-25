return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ 'tpope/vim-dadbod',                     lazy = true },
		{ 'kristijanhusak/vim-dadbod-completion', ft = { 'javascript' }, lazy = true },
	},
	ft = { 'javascript' },
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.o.filetype = 'javascript'
	end,
	config = function()
		vim.keymap.set("n", '<leader>du', '<CMD>DBUIToggle<CR>')
		vim.keymap.set("n", '<leader>dl', '<CMD>DBUILastQueryInfo<CR>')

		vim.o.filetype = 'javascript'
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"javascript",
			},
			command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
				"javascript",
			},
			callback = function()
				vim.schedule(function()
					require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
				end
				)
			end,
		})
-- nnoremap <silent> <leader>du :DBUIToggle<CR>
-- nnoremap <silent> <leader>df :DBUIFindBuffer<CR>
-- nnoremap <silent> <leader>dr :DBUIRenameBuffer<CR>
-- nnoremap <silent> <leader>dl :DBUILastQueryInfo<CR>
	end,
}
