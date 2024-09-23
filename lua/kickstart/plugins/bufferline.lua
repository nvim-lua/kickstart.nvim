return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    requires = 'kyazdani42/nvim-web-devicons', -- certifique-se de que 'requires' esteja correto
    config = function()
      local bufferline = require 'bufferline' -- Ajuste aqui: defina 'bufferline' corretamente
      bufferline.setup {
        options = {
          mode = 'buffers',
          style_preset = 'default', -- 'default' é uma string aqui, sem necessidade do bufferline.style_preset
          themable = true,
          numbers = 'none',
          close_command = 'bdelete! %d',
          right_mouse_command = 'bdelete! %d',
          left_mouse_command = 'buffer %d',
          middle_mouse_command = nil,
          indicator = {
            icon = '▎',
            style = 'icon',
          },
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' },
          },
          buffer_close_icon = '󰅖',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          name_formatter = function(buf) -- altere ou mantenha conforme necessário
            -- seu código de formatação aqui
          end,
          max_name_length = 18,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 18,
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level)
            local icon = level:match 'error' and ' ' or ''
            return ' ' .. icon .. count
          end,
          -- e assim por diante para as outras opções...
          -- Coloque suas demais configurações aqui
        },
      }

      -- Agora adicionamos os mapeamentos de teclas
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      map('n', '<leader>bp', ':BufferLinePick<CR>', opts)
      map('n', '<leader>bc', ':BufferLinePickClose<CR>', opts)
      map('n', '<A-.>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
      map('n', '<A-,>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
    end,
  },
}
