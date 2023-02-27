return {
	'nvim-orgmode/orgmode',
	ft = { 'org' },
	config = function()
		require('orgmode').setup {}
	end
}
