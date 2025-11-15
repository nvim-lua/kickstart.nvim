return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = {
		{ 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- `build` is used to run some command when the plugin is installed/updated.
      build = 'make',
      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
	},
  config = function()
    require('telescope').setup({})
		local keymap = vim.keymap.set
    local builtin = require 'telescope.builtin'
    keymap('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    keymap('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    keymap('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    keymap('n', '<leader>fa', builtin.find_files, {  desc = '[F]ind [A]ll Files' })
    keymap('n', '<leader>fs', builtin.builtin, { desc = '[F]ind Telescope' })
    keymap('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
    keymap('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    keymap('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    keymap('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
    keymap('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    keymap('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

		keymap('n', '<leader>fn', function()
			builtin.find_files { cwd = vim.fn.stdpath 'config' }
		end, { desc = '[S]earch [N]eovim files' })

	  end,
}
