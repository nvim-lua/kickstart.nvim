return {
	'David-Kunz/cmp-npm',
	config = function()
		require('cmp-npm').setup()
		local cmp = require('cmp')
		local config = cmp.get_config()
		table.insert(config.sources, {
			name = 'npm', keyword_length = 4
		})
		cmp.setup(config)
	end
}
