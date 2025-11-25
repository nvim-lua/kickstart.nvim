return {
  dir = vim.fn.stdpath 'config' .. '/lua/theme-switcher',
  name = 'theme-switcher',
  lazy = false,
  priority = 100,
  config = function()
    require('theme-switcher').setup {
      save_on_select = true,
      preview_on_navigate = true,
      restore_on_startup = true,
    }

    -- Keybindings (global, not buffer-specific)
    vim.keymap.set('n', '<leader>tt', function()
      require('theme-switcher').open()
    end, { desc = '[T]heme [T]oggle', noremap = true, silent = true })
  end,
}
