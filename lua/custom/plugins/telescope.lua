return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup {
      defaults = {
        prompt_prefix = '🔍 ',
        selection_caret = '➤ ',
        path_display = { 'truncate' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          theme = 'dropdown',
          previewer = false,
        },
        buffers = {
          theme = 'dropdown',
          previewer = false,
          initial_mode = 'normal',
        },
      },
      extensions = {
        file_browser = {
          theme = 'ivy',
          hijack_netrw = true,
        },
      },
    }

    -- Load extensions
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'file_browser')
  end,
}
