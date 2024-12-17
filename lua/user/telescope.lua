local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.load_extension('media_files')

local actions = require "telescope.actions"
local builtin = require 'telescope.builtin'

--       -- Enable Telescope extensions if they are installed
--       pcall(require('telescope').load_extension, 'fzf')
--       pcall(require('telescope').load_extension, 'ui-select')
-- 
-- 
--       -- Slightly advanced example of overriding default behavior and theme
--       vim.keymap.set('n', '<leader>/', function()
--         -- You can pass additional configuration to Telescope to change the theme, layout, etc.
--         builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--           winblend = 10,
--           previewer = false,
--         })
--       end, { desc = '[/] Fuzzily search in current buffer' })
-- 
--       -- It's also possible to pass additional configuration options.
--       --  See `:help telescope.builtin.live_grep()` for information about particular keys
--       vim.keymap.set('n', '<leader>s/', function()
--         builtin.live_grep {
--           grep_open_files = true,
--           prompt_title = 'Live Grep in Open Files',
--         }
--       end, { desc = '[S]earch [/] in Open Files' })
-- 
--       -- Shortcut for searching your Neovim configuration files
--       vim.keymap.set('n', '<leader>sn', function()
--         builtin.find_files { cwd = vim.fn.stdpath 'config' }
--       end, { desc = '[S]earch [N]eovim files' })
--     end,
--   },
-- 

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,

      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    planets = {
      show_pluto = true,
    },
  },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      -- find command (defaults to `fd`)
      find_cmd = "rg"
    }
  },
}
