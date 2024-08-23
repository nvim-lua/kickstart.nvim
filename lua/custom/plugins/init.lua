-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  require('mini.surround').setup(),

  require('mini.pairs').setup(),

  require('mini.indentscope').setup {
    options = { try_as_border = true },
    symbol = '│',
    draw = {
      delay = 200,
      animation = function()
        return 1
      end,
    },
  },
  --fix terraform and hcl comment string
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('FixTerraformCommentString', { clear = true }),
    callback = function(ev)
      vim.bo[ev.buf].commentstring = '# %s'
    end,
    pattern = { 'terraform', 'hcl' },
  }),
}
