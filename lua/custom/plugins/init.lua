-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)

vim.cmd('set autochdir')
-- custom/plugins/keymappings.lua

-- Function to set up your custom keymappings
local function setup_keymappings()
  -- Map <Leader>t to open a terminal in a vertical split on the right
  vim.api.nvim_set_keymap('n', '<Leader>t', ':vsplit | wincmd l | terminal<CR>', { noremap = true, silent = true })
end

-- Call the function to set up your keymappings
setup_keymappings()

-- See the kickstart.nvim README for more information
return {}
