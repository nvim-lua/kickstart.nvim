return {
	'elixir-tools/elixir-tools.nvim',
	config = function()
		require('elixir.projectionist.init').setup()
	end,
}
