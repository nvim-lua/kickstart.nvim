return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
	event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	keys = {
		{
			"<leader>vs", "<cmd>:VenvSelect<cr>",
			-- Key mapping for directly retrieving from cache. You may set an autocmd if you prefer the hands-free approach.
			"<leader>vc", "<cmd>:VenvSelectCached<cr>"
		}
	},
	config = function()
		-- Function to find the nearest venv path in parent directories.
		local function find_nearest_venv(starting_path)
			local current_path = starting_path
			while current_path do
				local venv_path = current_path .. '/venv/bin/python'
				if vim.fn.filereadable(venv_path) == 1 then
					return venv_path
				end
				local parent_path = vim.fn.fnamemodify(current_path, ':h')
				if parent_path == current_path then
					break
				end
				current_path = parent_path
			end
			return nil
		end

		-- Get the path of the current file.
		local current_file = vim.fn.expand('%:p')

		-- Get the venv path for the current project directory.
		local venv_path = find_nearest_venv(current_file)

		if venv_path then
			-- Activate the venv and use its Python interpreter.
			vim.g.venv_selector_auto_activate = 1
			vim.g.python3_host_prog = venv_path
		else
			-- Fallback to a system-wide Python interpreter.
			vim.g.python3_host_prog = '/usr/bin/python3'
		end
	end
}
