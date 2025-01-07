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
  end,
}
