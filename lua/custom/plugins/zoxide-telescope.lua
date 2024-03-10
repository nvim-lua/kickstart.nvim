-- Useful for easily creating commands

return {
  {
    'nvim-lua/popup.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
  },
  {
    'jvgrootveld/telescope-zoxide',
    config = function()
      local t = require 'telescope'
      local z_utils = require 'telescope._extensions.zoxide.utils'

      -- Configure the extension
      t.setup {
        extensions = {
          zoxide = {
            prompt_title = '[ Walking on the shoulders of TJ ]',
            mappings = {
              default = {
                after_action = function(selection)
                  print('Update to (' .. selection.z_score .. ') ' .. selection.path)
                end,
              },
              ['<C-s>'] = {
                before_action = function(selection)
                  print 'before C-s'
                end,
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end,
              },
              ['<C-q>'] = { action = z_utils.create_basic_command 'split' },
            },
          },
        },
      }

      -- Load the extension
      t.load_extension 'zoxide'

      -- Add a mapping
      vim.keymap.set('n', '<leader>sz', t.extensions.zoxide.list, { desc = 'zoxide search' })
    end,
  },
}
