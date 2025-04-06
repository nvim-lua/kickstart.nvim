return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
        offsets = {
          {
            filetype = 'NvimTree',
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    }
    vim.keymap.set('n', 'bk', ':BufferLinePick<CR>', { silent = true })
    vim.keymap.set('n', 'bkk', ':BufferLinePickClose<CR>', { silent = true })
    vim.keymap.set('n', 'bl', ':BufferLineCloseLeft<CR>', { silent = true })
    vim.keymap.set('n', 'br', ':BufferLineCloseRight<CR>', { silent = true })
    --  Remaps
    vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { silent = true })
    vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { silent = true })
    vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { silent = true })
    vim.keymap.set('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', { silent = true })
    vim.keymap.set('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', { silent = true })
    vim.keymap.set('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', { silent = true })
    vim.keymap.set('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', { silent = true })
    vim.keymap.set('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', { silent = true })
    vim.keymap.set('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', { silent = true })
    vim.keymap.set('n', '<leader>$', ':BufferLineGoToBuffer -1<CR>', { silent = true })
  end,
}
