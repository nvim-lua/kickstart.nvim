-- [[ Configure Treesitter ]]
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

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = true,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Find [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Find current [W]ord' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Find [D]iagnostics' })
-- vim.keymap.set('n', '<leader>fr', require('telescope.builtin').registers, { desc = 'Find [R]egister' })
vim.keymap.set('n', '<leader>fF', function()
  require('telescope.builtin').find_files { hidden = true, no_ignore = true }
end, { desc = '[S]earch [R]esume' })

vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Find by [G]rep' })
vim.keymap.set('n', '<leader>fG', function()
  require('telescope.builtin').live_grep {
    additional_args = function(args)
      return vim.list_extend(args, { '--hidden', '--no-ignore' })
    end,
  }
end, { desc = 'Find by [G]rep In all Files' })

-- Replace in the Quickfix list
function QuickfixReplace(search, replace)
  vim.fn.setqflist {}
  local bufnr = vim.fn.bufnr '%'
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for lnum, line in ipairs(lines) do
    if string.match(line, search) then
      local replaced_line = string.gsub(line, search, replace)
      vim.fn.setqflist { { bufnr = bufnr, lnum = lnum, text = replaced_line } }
    end
  end
  vim.cmd 'cwindow'
end

vim.api.nvim_set_keymap('n', '<leader>fr', ':lua QuickfixReplace(vim.fn.input("Search: "), vim.fn.input("Replace: "))<CR>', { noremap = true })
