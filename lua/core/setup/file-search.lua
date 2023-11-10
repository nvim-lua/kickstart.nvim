-- [[ Configure Telescope ]]

-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    file_ignore_patterns = { ".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
      "%.pdf", "%.mkv", "%.mp4", "%.zip" },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
