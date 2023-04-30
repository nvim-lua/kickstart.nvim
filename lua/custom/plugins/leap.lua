return {
	'ggandor/leap.nvim',
	version = "*",
	config = function ()
		require('leap').add_default_mappings()
	end,
}
