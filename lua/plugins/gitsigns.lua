-- Displays git changes in gutter
return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	'lewis6991/gitsigns.nvim',
	opts = {
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then
						return ']c'
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
				return '<Ignore>'
			end, { expr = true, desc = 'Jump to next hunk' })

			map({ 'n', 'v' }, '[c', function()
				if vim.wo.diff then
					return '[c'
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return '<Ignore>'
			end, { expr = true, desc = 'Jump to previous hunk' })

			-- Actions
			-- visual mode
			map('v', '<leader>ghs', function()
				gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
			end, { desc = '[S]tage [G]it [H]unk' })
			map('v', '<leader>ghr', function()
				gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
			end, { desc = '[R]eset [G]it [H]unk' })
			-- normal mode
			map('n', '<leader>ghs', gs.stage_hunk, { desc = '[G]it [S]tage [H]unk' })
			map('n', '<leader>ghr', gs.reset_hunk, { desc = '[G]it [R]eset [H]unk' })
			map('n', '<leader>ghS', gs.stage_buffer, { desc = '[G]it [S]tage buffer' })
			map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = '[U]ndo stage [H]unk' })
			map('n', '<leader>ghR', gs.reset_buffer, { desc = '[G]it [R]eset buffer' })
			map('n', '<leader>ghp', gs.preview_hunk, { desc = '[P]review [G]it [H]unk' })
			map('n', '<leader>ghb', function()
				gs.blame_line { full = false }
			end, { desc = '[G]it blame line' })

			-- Toggles
			map('n', '<leader>ghx', gs.toggle_deleted, { desc = 'toggle [G]it show deleted' })

			-- Text object
			map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select [G]it [H]unk' })
		end
	}
}
