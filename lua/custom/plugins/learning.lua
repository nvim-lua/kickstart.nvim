-- lua/custom/plugins/learning.lua
return {
  dir = '~/Developer/Personal/learning/nvim-plugins/first-plugin',
  config = function()
    vim.keymap.set('v', '<leader>ai', function()
      require('plugin').hello_world()
    end)
  end,
  desc = 'My first nvim plugin that replaces text in visual mode from an external script/cli tool',
}
