-- [[ Telescope fuzzy finder ]]
-- Telescope is set up the first time a picker is opened, which keeps it out
-- of startup time.

local did_setup = false
local function builtin()
  if not did_setup then
    did_setup = true
    local telescope = require 'telescope'
    telescope.setup {
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }
    -- Extensions (fzf is only there if `make` built it)
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
  end
  return require 'telescope.builtin'
end

-- Route vim.ui.select (code actions etc.) through telescope's ui-select.
-- Loading the extension replaces vim.ui.select; fall back to the default if it didn't.
local default_select = vim.ui.select
local function lazy_select(...)
  builtin()
  if vim.ui.select == lazy_select then
    vim.ui.select = default_select
  end
  return vim.ui.select(...)
end
vim.ui.select = lazy_select

local function map(lhs, picker, desc, opts)
  vim.keymap.set('n', lhs, function()
    builtin()[picker](opts and opts() or nil)
  end, { desc = desc })
end

map('<leader>fh', 'help_tags', 'Help')
map('<leader>fk', 'keymaps', 'Keymaps')
map('<leader>fc', 'commands', 'Commands')
map('<leader>ff', 'find_files', 'Files')
map('<leader>ft', 'builtin', 'Telescope')
map('<leader>f.', 'grep_string', 'word under cursor')
map('<leader>fw', 'live_grep', 'Word')
map('<leader>fd', 'diagnostics', 'Diagnostics')
map('<leader>f<cr>', 'resume', 'Resume')
map('<leader>fr', 'oldfiles', 'Recent Files')
map('<leader>fb', 'buffers', 'Buffers')
map('<leader>uc', 'colorscheme', 'Find Colorscheme')

map('<leader>b/', 'current_buffer_fuzzy_find', '/ Fuzzily search in current buffer', function()
  return require('telescope.themes').get_dropdown { winblend = 10, previewer = false }
end)
map('<leader>f/', 'live_grep', 'Find / in Open Files', function()
  return { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
end)

-- Neovim config shortcuts
map('<leader>fnf', 'find_files', 'Find Neovim Files', function()
  return { cwd = vim.fn.stdpath 'config' }
end)
map('<leader>fnw', 'live_grep', 'Find Neovim Words', function()
  return { cwd = vim.fn.stdpath 'config' }
end)

-- lsp.lua uses this to open the LSP pickers
return builtin
