return {
	{
		'akinsho/toggleterm.nvim',
		opts = {
			version = "*",
			size = 20,
			open_mapping = [[c-\]],
			hide_numbers = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shel = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		}
	}
}
