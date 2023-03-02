return {
	-- Toggleterm: multiple terminals
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require("toggleterm").setup {
				-- size can be a number or function which is passed the current terminal
				size = 10,
				autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
				start_in_insert = true,
				insert_mappings = true, -- whether or not the open mapping applies in insert mode
				terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
				persist_size = true,
				persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
				direction = 'tab',
				close_on_exit = false, -- close the terminal window when the process exits
				shell = vim.o.shell, -- change the default shell
				auto_scroll = true, -- automatically scroll to the bottom on terminal output
				open_mapping = [[<F7>]],
				shading_factor = 2,
			}

			-- Set Terminal Keymaps
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

			-- Set config for LazyGit
			local Terminal = require('toggleterm.terminal').Terminal
			local lazygit  = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "double",
				},
				-- function to run on opening the terminal
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				end,
				-- function to run on closing the terminal
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _lazygit_toggle()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>",
				{ noremap = true, silent = true, desc = "LazyGit Toggle" })
		end
	}
}
