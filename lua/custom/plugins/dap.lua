return {
  -- Add the nvim-dap related plugins
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui', opt = true, cmd = 'DapUI' },
      { 'nvim-neotest/nvim-nio', opt = true, cmd = 'Neotest' },
      { 'theHamsta/nvim-dap-virtual-text', opt = true, ft = { 'python', 'go', 'rust' } },
      { 'mfussenegger/nvim-dap-python', opt = true, ft = 'python' },
      { 'leoluz/nvim-dap-go', opt = true, ft = 'go' },
      { 'simrat39/rust-tools.nvim', opt = true, ft = 'rust' },
      'williamboman/mason.nvim', -- Mason for managing external tools
      'williamboman/mason-lspconfig.nvim'
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      local dap_virtual_text = require('nvim-dap-virtual-text')
      local mason_registry = require('mason-registry')

      -- Initialize dap-ui
      dapui.setup()
      -- Initialize dap-virtual-text
      dap_virtual_text.setup()

      -- Keybindings
      vim.api.nvim_set_keymap('n', '<leader>dc', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ds', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>di', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>do', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>dB', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>du', ':lua require"dapui".toggle()<CR>', { noremap = true, silent = true })

      -- DAP Python
      local function get_python_path()
        local cwd = vim.fn.getcwd()
        if vim.env.VIRTUAL_ENV then
          return vim.env.VIRTUAL_ENV .. '/bin/python'
        elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        else
          return 'python'
        end
      end

      require('dap-python').setup(get_python_path())

      -- DAP Go
      require('dap-go').setup()

      -- DAP Rust
      local rust_tools = require('rust-tools')

      -- Ensure codelldb is installed via Mason
      local codelldb_package = mason_registry.get_package('codelldb')
      local codelldb_path = codelldb_package:get_install_path()
      local codelldb_adapter = codelldb_path .. '/extension/adapter/codelldb'
      local codelldb_lib = codelldb_path .. '/extension/lldb/lib/liblldb.so'

      rust_tools.setup({
        tools = {
          autoSetHints = true,
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
          },
        },
        server = {
          on_attach = function(_, bufnr)
            -- DAP Rust keymaps
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dr', ':RustDebuggables<CR>', { noremap = true, silent = true })
            -- Keybind for RustHoverActions
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', ':RustHoverActions<CR>', { noremap = true, silent = true })
          end,
        },
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_adapter,
            codelldb_lib
          ),
        },
      })

      -- DAP UI integration
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Define signs for breakpoints
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '🟢', texthl = '', linehl = '', numhl = '' })
    end,
    keys = {
      { 'n', '<leader>dc', ':lua require"dap".continue()<CR>' },
      { 'n', '<leader>ds', ':lua require"dap".step_over()<CR>' },
      { 'n', '<leader>di', ':lua require"dap".step_into()<CR>' },
      { 'n', '<leader>do', ':lua require"dap".step_out()<CR>' },
      { 'n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>' },
      { 'n', '<leader>dB', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>' },
      { 'n', '<leader>dr', ':lua require"dap".repl.open()<CR>' },
      { 'n', '<leader>du', ':lua require"dapui".toggle()<CR>' }
    },
    ft = { 'python', 'go', 'rust' }
  }
}

