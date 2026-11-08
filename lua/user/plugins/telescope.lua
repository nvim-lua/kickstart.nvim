-- [[ Telescope fuzzy finder ]]

local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'

telescope.setup {
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    ['ui-select'] = {
      themes.get_dropdown(),
    },
  },
}

-- Extensions (fzf is only there if `make` built it)
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')

vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = 'Telescope' })
vim.keymap.set('n', '<leader>f.', builtin.grep_string, { desc = 'word under cursor' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Word' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>f<cr>', builtin.resume, { desc = 'Resume' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent Files' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>uc', builtin.colorscheme, { desc = 'Find Colorscheme' })

vim.keymap.set('n', '<leader>b/', function()
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '/ Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>f/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = 'Find / in Open Files' })

-- Neovim config shortcuts
vim.keymap.set('n', '<leader>fnf', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Find Neovim Files' })
vim.keymap.set('n', '<leader>fnw', function()
  builtin.live_grep { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Find Neovim Words' })
