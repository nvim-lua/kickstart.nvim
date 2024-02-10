return {
	"saecki/crates.nvim",
	ft = { "rust", "toml" },
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local crates = require('crates')
		crates.setup()
		-- require('cmp').setup.buffer({
		--	sources = { { name = 'crates' } }
		-- })
		crates.show()
	end,
}
