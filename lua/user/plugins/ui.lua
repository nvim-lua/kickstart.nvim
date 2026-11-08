-- [[ UI ]]

-- which-key: shows pending keybinds and names the <leader> groups
require('which-key').setup {
  spec = {
    { '<leader>b', group = 'buffer' },
    { '<leader>f', group = 'find' },
    { '<leader>fn', group = 'neovim config' },
    { '<leader>g', group = 'git' },
    { '<leader>gd', group = 'diff' },
    { '<leader>l', group = 'language' },
    { '<leader>p', group = 'plugins' },
    { '<leader>t', group = 'toggle' },
    { '<leader>u', group = 'ux' },
    { '<leader>w', group = 'workspace' },
    { '<leader>x', group = 'quicklist' },
  },
}
vim.keymap.set('n', '<leader>?', function()
  require('which-key').show { global = false }
end, { desc = 'Buffer Local Keymaps (which-key)' })

-- Status line
require('lualine').setup {
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(res)
          return res:sub(1, 1)
        end,
      },
    },
    lualine_b = { 'filename' },
    lualine_c = { 'branch' },
    lualine_x = { 'diagnostics' },
    lualine_y = { 'diff' },
    lualine_z = {
      function()
        return ' ' .. os.date '%R'
      end,
    },
  },
}

-- Buffer tabs
require('bufferline').setup {
  options = {
    separator_style = 'slant',
  },
}

-- Indentation guides
require('ibl').setup {}

-- Highlight TODO/FIXME/NOTE comments
require('todo-comments').setup { signs = false }

-- LSP progress messages
require('fidget').setup {}

-- nvim-scrollview needs no setup
