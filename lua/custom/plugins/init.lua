---@diagnostic disable: lowercase-global
-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {}
      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }
      function _lazygit_toggle()
        lazygit:toggle()
      end
      vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true, desc = 'Toggle Lazygit' })

      local terminal = Terminal:new { hidden = true }
      function _terminal_toggle()
        terminal:toggle()
      end
      vim.api.nvim_set_keymap('n', '<leader>gt', '<cmd>lua _terminal_toggle()<CR>', { noremap = true, silent = true, desc = 'Toggle Terminal' })
    end,
  },
  {
    'willothy/nvim-cokeline',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required for v0.4.0+
      'nvim-tree/nvim-web-devicons', -- If you want devicons
      'stevearc/resession.nvim', -- Optional, for persistent history
    },
    config = function()
      local is_picking_focus = require('cokeline.mappings').is_picking_focus
      local is_picking_close = require('cokeline.mappings').is_picking_close
      local get_hex = require('cokeline.hlgroups').get_hl_attr
      local red = vim.g.terminal_color_1
      local yellow = vim.g.terminal_color_3
      require('cokeline').setup {
        default_hl = {
          fg = function(buffer)
            return buffer.is_focused and get_hex('Normal', 'fg') or get_hex('Comment', 'fg')
          end,
          bg = function()
            return get_hex('ColorColumn', 'bg')
          end,
        },
        components = {
          {
            text = function(buffer)
              return (buffer.index ~= 1) and '?' or ''
            end,
          },
          {
            text = '  ',
          },
          {
            text = function(buffer)
              return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. ' ' or buffer.devicon.icon
            end,
            fg = function(buffer)
              return (is_picking_focus() and yellow) or (is_picking_close() and red) or buffer.devicon.color
            end,
            italic = function()
              return (is_picking_focus() or is_picking_close())
            end,
            bold = function()
              return (is_picking_focus() or is_picking_close())
            end,
          },
          {
            text = ' ',
          },
          {
            text = function(buffer)
              return buffer.filename .. '  '
            end,
            bold = function(buffer)
              return buffer.is_focused
            end,
          },
          {
            text = '󰖭',
            on_click = function(_, _, _, _, buffer)
              buffer:delete()
            end,
          },
          {
            text = '  ',
          },
        },
      }
      local map = vim.api.nvim_set_keymap
      map('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
      map('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
      map('n', '<leader>bc', '<Plug>(cokeline-pick-close)', { silent = true, desc = 'Pick tab to close' })
    end,
  },
}
