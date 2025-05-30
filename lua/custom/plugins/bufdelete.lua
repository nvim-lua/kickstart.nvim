-- filepath: /home/kali/.config/nvim/lua/custom/plugins/bufdelete.lua
-- Bufdelete for properly closing buffers
-- https://github.com/famiu/bufdelete.nvim

return {
  'famiu/bufdelete.nvim',
  event = "VeryLazy", -- lazy load
  config = function()
    -- Key mappings to delete buffers
    vim.keymap.set('n', '<leader>bd', function()
      require("bufdelete").bufdelete(0, false)
    end, {noremap = true, desc = "Delete buffer"})
    
    vim.keymap.set('n', '<leader>bD', function()
      require("bufdelete").bufdelete(0, true)
    end, {noremap = true, desc = "Delete buffer (force)"})
  end
}
