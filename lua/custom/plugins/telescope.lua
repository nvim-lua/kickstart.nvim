return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = "VimEnter",
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'debugloop/telescope-undo.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- Configure Telescope
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })

    -- Telescope live_grep in git root
    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir = current_file == '' and vim.fn.getcwd() or vim.fn.fnamemodify(current_file, ':h')

      -- Find the Git root directory from the current file's path
      local git_root =
          vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
      if vim.v.shell_error ~= 0 then
        print('Not a git repository. Searching on the current working directory.')
        return vim.fn.getcwd()
      end
      return git_root
    end

    -- Custom live_grep function to search in git root
    local function live_grep_git_root()
      local git_root = find_git_root()
      if git_root then
        require('telescope.builtin').live_grep({
          search_dirs = { git_root },
        })
      end
    end

    -- Define a user command for live_grep_git_root
    vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
  end,
}

