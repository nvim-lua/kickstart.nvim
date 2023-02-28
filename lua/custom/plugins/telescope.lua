return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {'nvim-lua/plenary.nvim'},
  config = function()
    -- Find files using lua fuctions
    local opts = {silent = true, noremap = true}
    vim.api.nvim_set_keymap('n', '<Leader>ff',
                            "<Cmd>lua require'telescope.builtin'.find_files()<CR>",
                            {silent = false, noremap = true})
    vim.api.nvim_set_keymap('n', '<Leader>fg',
                            "<Cmd>lua require'telescope.builtin'.live_grep()<CR>", opts)
    vim.api.nvim_set_keymap('n', '<Leader>fs',
                            "<Cmd>lua require'telescope.builtin'.grep_string()<CR>", opts)
    vim.api.nvim_set_keymap('n', '<Leader>ft',
                            "<Cmd>lua require'telescope.builtin'.file_browser()<CR>", opts)
    vim.api.nvim_set_keymap('n', '<Leader>fo', "<Cmd>lua require'telescope.builtin'.oldfiles()<CR>",
                            opts)
    vim.api.nvim_set_keymap('n', '<Leader>gc',
                            "<Cmd>lua require'telescope.builtin'.git_commits()<CR>", opts)
    vim.api.nvim_set_keymap('n', '<Leader>gb',
                            "<Cmd>lua require'telescope.builtin'.git_branches()<CR>", opts)
    vim.api.nvim_set_keymap('n', '<Leader>fb', "<Cmd>lua require'telescope.builtin'.buffers()<CR>",
                            opts)
    vim.api.nvim_set_keymap('n', '<Leader>fh',
                            "<Cmd>lua require'telescope.builtin'.help_tags()<CR>", opts)

    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        -- program to use for searching with its arguments
        find_command = {
          'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
        },
        -- prompt_position = 'top', -- have prompt at the top (has no effect on vertical configuration)
        prompt_prefix = ' ', -- symbol on prompt window
        selection_caret = ' ', -- symbol on selected row in results window
        entry_prefix = '  ', -- symbol on non-selected rows in results window
        initial_mode = 'insert', -- start in insert mode
        selection_strategy = 'reset', -- what happens to selection when list changes
        sorting_strategy = 'ascending', -- start with most important search on top
        layout_strategy = 'horizontal', -- vertical layout
        layout_config = {prompt_position = 'top'},
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {'node_modules/.*'}, -- never search in node_modules/ dir
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        display_path = true,
        winblend = 0, -- window should not be transparent
        border = {}, -- no border?
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'}, -- border chars
        color_devicons = true, -- colorize used icons
        use_less = true, -- less is bash program for preview file contents
        set_env = {['COLORTERM'] = 'truecolor'}, -- use all the colors
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        -- preview_cutoff = 120,
        mappings = {
          i = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            -- ['ć'] = actions.close,
            ['<CR>'] = actions.select_default + actions.center
          },
          n = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            ['ć'] = actions.close
          }
        }
      },
      extensions = {fzy_native = {override_generic_sorter = false, override_file_sorter = true}}
    }
  end
}
