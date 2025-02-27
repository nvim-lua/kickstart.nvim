return {
  'elmcgill/springboot-nvim',
  depedencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-jdtls',
  },
  config = function()
    local springboot_nvim = require 'springboot-nvim'
    vim.keymap.set('n', '<leader>Jr', springboot_nvim.boot_run, { desc = 'Spring Boot Run Project' })
    vim.keymap.set('n', '<leader>Jc', springboot_nvim.generate_class, { desc = 'Java Create Class' })
    vim.keymap.set('n', '<leader>Ji', springboot_nvim.generate_interface, { desc = 'Java Create Interface' })
    vim.keymap.set('n', '<leader>Je', springboot_nvim.generate_enum, { desc = 'Java Create Enum' })
    springboot_nvim.setup {}
  end,
}
