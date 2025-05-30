-- filepath: /home/kali/.config/nvim/lua/custom/plugins/bufferline.lua
-- Bufferline configuration
-- https://github.com/akinsho/bufferline.nvim

return {
  'akinsho/bufferline.nvim',
  version = "*", -- use the latest stable version
  event = "VeryLazy", -- lazy load for better startup
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- for file icons
  },
  opts = {
    options = {
      -- Themes and appearance
      indicator = {
        style = 'icon',
        icon = '▎',
      },
      buffer_close_icon = '󰅖',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 18,
      max_prefix_length = 15,
      truncate_names = true,
      tab_size = 18,
      diagnostics = "nvim_lsp", -- Use LSP diagnostics
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          text_align = "center",
          separator = true
        }
      },
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = {'close'}
      },
    },
    -- Colorscheme integration
    highlights = {
      -- These are automatically integrated with your colorscheme
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    
    -- Key mappings for navigating between buffers
    vim.keymap.set('n', '<leader>bp', '<cmd>BufferLinePick<CR>', {noremap = true, desc = "Pick buffer"})
    vim.keymap.set('n', '<leader>bc', '<cmd>BufferLinePickClose<CR>', {noremap = true, desc = "Pick buffer to close"})
    vim.keymap.set('n', '<leader>bh', '<cmd>BufferLineCyclePrev<CR>', {noremap = true, desc = "Previous buffer"})
    vim.keymap.set('n', '<leader>bl', '<cmd>BufferLineCycleNext<CR>', {noremap = true, desc = "Next buffer"})
    vim.keymap.set('n', '<leader>bH', '<cmd>BufferLineMovePrev<CR>', {noremap = true, desc = "Move buffer left"})
    vim.keymap.set('n', '<leader>bL', '<cmd>BufferLineMoveNext<CR>', {noremap = true, desc = "Move buffer right"})
    vim.keymap.set('n', '<leader>b1', '<cmd>BufferLineGoToBuffer 1<CR>', {noremap = true, desc = "Go to buffer 1"})
    vim.keymap.set('n', '<leader>b2', '<cmd>BufferLineGoToBuffer 2<CR>', {noremap = true, desc = "Go to buffer 2"})
    vim.keymap.set('n', '<leader>b3', '<cmd>BufferLineGoToBuffer 3<CR>', {noremap = true, desc = "Go to buffer 3"})
    vim.keymap.set('n', '<leader>b4', '<cmd>BufferLineGoToBuffer 4<CR>', {noremap = true, desc = "Go to buffer 4"})
    vim.keymap.set('n', '<leader>b5', '<cmd>BufferLineGoToBuffer 5<CR>', {noremap = true, desc = "Go to buffer 5"})
    vim.keymap.set('n', '<leader>b6', '<cmd>BufferLineGoToBuffer 6<CR>', {noremap = true, desc = "Go to buffer 6"})
    vim.keymap.set('n', '<leader>b7', '<cmd>BufferLineGoToBuffer 7<CR>', {noremap = true, desc = "Go to buffer 7"})
    vim.keymap.set('n', '<leader>b8', '<cmd>BufferLineGoToBuffer 8<CR>', {noremap = true, desc = "Go to buffer 8"})
    vim.keymap.set('n', '<leader>b9', '<cmd>BufferLineGoToBuffer 9<CR>', {noremap = true, desc = "Go to buffer 9"})
    
    -- Additional keymaps for Alt+number to switch buffers quickly
    for i = 1, 9 do
      vim.keymap.set('n', string.format('<A-%s>', i), string.format('<cmd>BufferLineGoToBuffer %s<CR>', i), 
        {noremap = true, desc = string.format("Go to buffer %s", i)})
    end
  end,
}
