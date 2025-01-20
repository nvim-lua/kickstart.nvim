return {
  setup = function()
    -- You can add your own plugins here or in other files in this directory!
    --  I promise not to create any merge conflicts in this directory :)
    --
    -- See the kickstart.nvim README for more information
    vim.cmd.colorscheme 'retrobox'

    vim.cmd.set 'tabline=no'
    vim.cmd.set 'nonumber'
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = true

    vim.keymap.set('', '<up>', '<nop>', { noremap = true })
    vim.keymap.set('', '<down>', '<nop>', { noremap = true })
    vim.keymap.set('i', '<up>', '<nop>', { noremap = true })
    vim.keymap.set('i', '<down>', '<nop>', { noremap = true })
    vim.keymap.set('i', '<left>', '<nop>', { noremap = true })
    vim.keymap.set('i', '<right>', '<nop>', { noremap = true })

    vim.opt.mouse = ''
    vim.opt.mousescroll = 'ver:0,hor:0'

    vim.api.nvim_create_user_command('ConfEdit', function()
      vim.cmd 'edit ~/.config/nvim/lua/custom/plugins/'
    end, { desc = 'Ouvrir le dossier des plugins personnalisés' })
  end,
}
