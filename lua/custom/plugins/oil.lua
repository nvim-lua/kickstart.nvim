return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-mini/mini.nvim' },
  config = function()
    require('mini.icons').setup()
    require('oil').setup {
      float = {
        border = 'rounded',
        title = ' Oil ',
        title_pos = 'center',
      },
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, '.')
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        natural_order = false,
        sort = {
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
      },
      keymaps = {
        ['<leader>th'] = {
          callback = function()
            require('oil').toggle_hidden()
          end,
          desc = 'Toggle hidden files',
          mode = 'n',
        },
      },
    }
  end,
}
