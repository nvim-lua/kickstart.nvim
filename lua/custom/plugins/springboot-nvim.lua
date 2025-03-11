return {
  'elmcgill/springboot-nvim',
  depedencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-jdtls',
    'folke/which-key',
  },
  config = function()
    local springboot_nvim = require 'springboot-nvim'
    local java_group = vim.api.nvim_create_augroup('java_commands', { clear = false })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'java' },
      callback = function()
        vim.api.nvim_buf_set_keymap(
          0,
          'n',
          '<leader>Jr',
          ':lua require("springboot-nvim").boot_run()<CR>',
          { desc = 'Spring Boot [R]un Project', noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          0,
          'n',
          '<leader>Jc',
          ':lua require("springboot-nvim").generate_class()<CR>',
          { desc = 'Java Create [C]lass', noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          0,
          'n',
          '<leader>Ji',
          ':lua require("springboot-nvim").generate_interface()<CR>',
          { desc = 'Java Create [I]nterface', noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          0,
          'n',
          '<leader>Je',
          ':lua require("springboot-nvim").generate_enum()<CR>',
          { desc = 'Java Create [E]num', noremap = true, silent = true }
        )
      end,
      group = java_group,
    })
    --vim.keymap.set('n', '<leader>Jr', springboot_nvim.boot_run, { desc = 'Spring Boot Run Project' })
    --vim.keymap.set('n', '<leader>Jc', springboot_nvim.generate_class, { desc = 'Java Create Class' })
    --vim.keymap.set('n', '<leader>Ji', springboot_nvim.generate_interface, { desc = 'Java Create Interface' })
    --vim.keymap.set('n', '<leader>Je', springboot_nvim.generate_enum, { desc = 'Java Create Enum' })

    local wk = require 'which-key'
    wk.add {
      { '<leader>J', group = '[J]ava' },
    }

    springboot_nvim.setup {}
  end,
}
