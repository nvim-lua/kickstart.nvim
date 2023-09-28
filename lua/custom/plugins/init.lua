-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  "olimorris/onedarkpro.nvim",
  config = function ()
    local keymap = vim.keymap

    -- select all
    keymap.set('n', '<C-a>', 'gg<S-v>G')

    -- always center
    keymap.set('n', 'j', 'jzz', { noremap = false, silent = true })
    keymap.set('n', 'k', 'kzz', { noremap = false, silent = true })

    -- escape insert mode
    keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true })

    -- split remaps
    keymap.set('n', 'ss', ':split<Return><C-w>w')
    keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
    keymap.set('n', '<Space>', '<C-w>w')
    keymap.set('', 'sh', '<C-w>h')
    keymap.set('', 'sk', '<C-w>k')
    keymap.set('', 'sj', '<C-w>j')
    keymap.set('', 'sl', '<C-w>l')

    -- Resize window
    keymap.set('n', 's,', '<C-w><')
    keymap.set('n', 's.', '<C-w>>')
    keymap.set('n', 's=', '<C-w>+')
    keymap.set('n', 's-', '<C-w>-')

    -- quit
    keymap.set('n', 'q', ':q<CR>', { silent = true })
    keymap.set('n', 'Q', ':q!<CR>', { silent = true })

    -- save
    keymap.set('n', 'sw', ':w<CR>', { silent = true })
  end
}
