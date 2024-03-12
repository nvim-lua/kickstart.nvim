-- startup screen
return {
	'echasnovski/mini.nvim',
	config = function()
		local mini = require('mini.starter');
		mini.setup({
			items = {
				-- FIX: either install telescope browser extension, or remove browser from telescope options
				mini.sections.telescope(),
				mini.sections.recent_files(5, true, true),
				mini.sections.builtin_actions(),
			},
			content_hooks = {
				mini.gen_hook.adding_bullet('-'),
				mini.gen_hook.aligning('center', 'center'),
			},
			footer = '',
		})
	end
}
