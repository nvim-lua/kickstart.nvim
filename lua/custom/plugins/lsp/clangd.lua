return {
  'neovim/nvim-lspconfig',
  ft = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  config = function()
    local function build_cmd(commands_dir)
      return {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=never',
        '--query-driver=' .. vim.fn.exepath 'clang++',
        '--resource-dir=' .. vim.fn.trim(vim.fn.system 'clang++ --print-resource-dir'),
        '--compile-commands-dir=' .. commands_dir,
      }
    end

    local function reload_clangd(commands_dir)
      commands_dir = commands_dir or './build/debug'
      local lspconfig = require 'lspconfig'

      lspconfig.clangd.setup {
        cmd = build_cmd(commands_dir),
        root_dir = lspconfig.util.root_pattern '.git',
        single_file_support = true,
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      }

      vim.cmd.edit()
    end

    local function pick_commands_dir()
      local pickers = require 'telescope.pickers'
      local finders = require 'telescope.finders'
      local conf = require('telescope.config').values
      pickers
        .new({}, {
          prompt_title = 'Choose compile_commands.json location',
          finder = finders.new_oneshot_job { 'fd', '-u', 'compile_commands.json', '-x', 'dirname', '{}' },
          sorter = conf.generic_sorter {},
          attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
              local entry = require('telescope.actions.state').get_selected_entry()
              local commands_dir = entry[1]
              require('telescope.actions').close(prompt_bufnr)
              reload_clangd(commands_dir)
            end)
            return true
          end,
        })
        :find()
    end

    reload_clangd()

    vim.keymap.set('n', '<leader>cc', pick_commands_dir, { desc = 'Pick location of compile_commands.json for clangd' })
  end,
}
