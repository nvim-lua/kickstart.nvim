return {
  -- add the nvim-dap related plugins
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui', opt = true, cmd = 'Dapui' },
      { 'nvim-neotest/nvim-nio', opt = true, cmd = 'Neotest' },
      { 'thehamsta/nvim-dap-virtual-text', opt = true, ft = { 'python', 'go', 'rust' } },
      { 'mfussenegger/nvim-dap-python', opt = true, ft = 'python' },
      { 'leoluz/nvim-dap-go', opt = true, ft = 'go' },
      { 'simrat39/rust-tools.nvim', opt = true, ft = 'rust' },
      'williamboman/mason.nvim', -- mason for managing external tools
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      local dap_virtual_text = require('nvim-dap-virtual-text')
      local mason_registry = require('mason-registry')

      -- initialize dap-ui
      dapui.setup()
      -- initialize dap-virtual-text
      dap_virtual_text.setup()

      -- dap python
      local function get_python_path()
        local cwd = vim.fn.getcwd()
        if vim.env.virtual_env then
          return vim.env.virtual_env .. '/bin/python'
        elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        else
          return 'python'
        end
      end

      require('dap-python').setup(get_python_path())

      -- dap go
      require('dap-go').setup()

      -- dap rust
      local rust_tools = require('rust-tools')

      -- ensure codelldb is installed via mason
      local codelldb_package = mason_registry.get_package('codelldb')
      local codelldb_path = codelldb_package:get_install_path()
      local codelldb_adapter = codelldb_path .. '/extension/adapter/codelldb'
      local codelldb_lib = codelldb_path .. '/extension/lldb/lib/liblldb.so'

      rust_tools.setup({
        tools = {
          autosethints = true,
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = '<- ',
            other_hints_prefix = '=> ',
          },
        },
        server = {
          on_attach = function(_, bufnr)
            -- dap rust keymaps
            vim.api.nvim_buf_set_keymap(
              bufnr,
              'n',
              '<leader>dr',
              ':rustdebuggables<cr>',
              { noremap = true, silent = true }
            )
            -- keybind for rusthoveractions
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'k', ':rusthoveractions<cr>', { noremap = true, silent = true })
          end,
        },
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_adapter, codelldb_lib),
        },
      })

      -- dap ui integration
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- define signs for breakpoints
      vim.fn.sign_define('dapbreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('dapstopped', { text = '🟢', texthl = '', linehl = '', numhl = '' })
    end,
    keys = {
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>ds',
        function()
          require('dap').step_over()
        end,
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>do',
        function()
          require('dap').step_out()
        end,
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>dsb',
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.open()
        end,
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        mode = 'n',
        noremap = true,
        silent = true,
      },
    },
    ft = { 'python', 'go', 'rust' },
  },
}
