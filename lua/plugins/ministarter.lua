-- startup screen
return {
	'echasnovski/mini.nvim',
    dependencies = {
		'nvim-telescope/telescope-file-browser.nvim',
    },
	config = function()
		local mini = require('mini.starter');
		mini.setup({
			items = {
				mini.sections.telescope(),
				mini.sections.recent_files(5, true, true),
				mini.sections.builtin_actions(),
			},
			content_hooks = {
				mini.gen_hook.adding_bullet(' '),
				mini.gen_hook.aligning('center', 'center'),
			},
			footer = '',
		})

		vim.keymap.set('n', '<leader>=', function()
			mini.open()
		end, { desc = 'Open starter' })
	end
}
