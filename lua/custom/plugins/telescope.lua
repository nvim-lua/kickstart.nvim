return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = {
          "node_modules/.*",
          "%.env",
          "yarn.lock",
          "package-lock.json",
          "lazy-lock.json",
          "init.sql",
          "target/.*",
          ".git/.*",
        },
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'flutter')

    builtin = require('telescope.builtin');

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Search [G]it [S]tatus' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations,
      { desc = '[G]o to [I]mplementations' })
    vim.keymap.set('n', '<leader>gr', builtin.lsp_references,
      { desc = '[G]o to [R]eferences' })
    vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions,
      { desc = '[G]o to [D]efinitions' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })


    -- Harpoon config:
    --

    -- local harpoon = require('harpoon')
    -- harpoon:setup({})
    --
    -- -- basic telescope configuration
    -- local conf = require("telescope.config").values
    --
    --
    -- local function toggle_telescope(harpoon_files)
    --   local make_finder = function()
    --     local paths = {}
    --     for _, item in ipairs(harpoon_files.items) do
    --       table.insert(paths, item.value)
    --     end
    --
    --     return require("telescope.finders").new_table({
    --       results = paths,
    --     })
    --   end
    --
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require("telescope.pickers").new({}, {
    --     prompt_title = "Harpoon",
    --     finder = make_finder(),
    --     previewer = conf.file_previewer({}),
    --     sorter = conf.generic_sorter({}),
    --     attach_mappings = function(prompt_buffer_number, map)
    --       map("n", "dd", function()
    --         local state = require("telescope.actions.state")
    --         local selected_entry = state.get_selected_entry()
    --         local current_picker = state.get_current_picker(prompt_buffer_number)
    --
    --         harpoon:list():removeAt(selected_entry.index)
    --         current_picker:refresh(make_finder())
    --       end)
    --
    --       return true
    --     end,
    --
    --   }):find()
    -- end
    --
    -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    --   { desc = "Open harpoon window" })
  end
}
