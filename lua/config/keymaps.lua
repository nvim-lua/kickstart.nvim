local map = vim.keymap.set
map('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- Clear highlights on search when pressing <C-c> in normal mode
--  See `:help hlsearch`
map('n', '<C-c>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- open Oil
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } )

-- Change current dir
map("n", "<leader>cc", "<cmd>cd %:p:h<CR>", { desc = "Change current dir to a current buffer" })

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape to Normal mode in terminal" })

map("v", "<leader>p", '"_dP', { desc = "Replace and paste with blackhole register" })

map("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })

map("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })

-- toggle window
local function toggle(bufname, open_window_func)

	local bufnr = vim.fn.bufnr(bufname)

	if bufnr ~= -1 then
		-- Remove buffer from memory
		vim.api.nvim_buf_delete(bufnr, { force = false })
		-- get window number where a buffer attaches to
		local wins = vim.fn.win_findbuf(bufnr)
			for _, win in ipairs(wins) do
				vim.api.nvim_win_close(win, false)
			end

	else
		open_window_func()
	end
end

-- toggle oil as a side bar
--map(
--	'n',
--	'<leader>-',
--	function ()
--		local function open_oil()
--			vim.cmd("vsplit")
--			vim.cmd("wincmd H")
--			vim.cmd("vertical resize 30")
--			vim.cmd("Oil")
--		end
--	toggle("oil://*", open_oil)
--	end,
--	{ desc = "Toggle Oil" }
--)

-- toggle terminal
map(
	'n',
	'<leader>t',
	function ()
    local function open_terminal()
			vim.cmd.new()
			vim.cmd.term()
			vim.cmd.wincmd("J")
			vim.api.nvim_win_set_height(0, 15)
			vim.cmd("startinsert")
		end
		toggle("term://*", open_terminal)
	end,
	{ desc = "Toggle Terminal" }
)

