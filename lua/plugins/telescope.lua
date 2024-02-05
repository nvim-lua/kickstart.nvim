-- Fuzzy finder
local function telescope_live_grep_open_files()
	require('telescope.builtin').live_grep {
		grep_open_files = true,
		prompt_title = 'Live Grep in Open Files',
	}
end

local function keymaps()
	vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
	vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
	vim.keymap.set('n', '<leader>/', function()
	  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	  })
	end, { desc = '[/] Fuzzily search in current buffer' })
	vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
	vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
	vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
	vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
	vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
	vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
	vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
	vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
end

return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',

		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},
	config = function()
		require('telescope').setup {
		  defaults = {
			mappings = {
			  i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			  },
			},
		  },
		}

		pcall(require('telescope').load_extension, 'fzf')

		local function find_git_root()
		  local current_file = vim.api.nvim_buf_get_name(0)
		  local current_dir
		  local cwd = vim.fn.getcwd()
		  if current_file == '' then
			current_dir = cwd
		  else
			current_dir = vim.fn.fnamemodify(current_file, ':h')
		  end

		  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
		  if vim.v.shell_error ~= 0 then
			print 'Not a git repository. Searching on current working directory'
			return cwd
		  end
		  return git_root
		end

		local function live_grep_git_root()
		  local git_root = find_git_root()
		  if git_root then
			require('telescope.builtin').live_grep {
			  search_dirs = { git_root },
			}
		  end
		end

		vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

		keymaps()
	end
}
