return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Красивый UI
    'rcarriga/nvim-dap-ui',
    -- Обязательная зависимость для UI
    'nvim-neotest/nvim-nio',
    -- Настройка для Go
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Настраиваем UI
    dapui.setup()

    -- Настраиваем Go (автоматически подхватит dlv)
    require('dap-go').setup()

    -- Автоматическое открытие/закрытие окна отладки
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    -- dap.listeners.before.event_terminated.dapui_config = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited.dapui_config = function()
    --   dapui.close()
    -- end

    -- КЛАВИШИ (Keymaps)

    -- Ставит точку остановки (Breakpoint) на текущей строке
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })

    -- Запуск / Продолжить (F5 - как везде)
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })

    -- Шаг внутрь (Step Into - F11)
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })

    -- Шаг через (Step Over - F10)
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })

    -- Шаг назад (Step Out - Shift+F11)
    vim.keymap.set('n', '<S-F11>', dap.step_out, { desc = 'Debug: Step Out' })

    -- Открыть UI вручную (если вдруг закрылся)
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })
    vim.keymap.set('n', '<leader>dt', function()
      require('dap-go').debug_test()
    end, { desc = 'Debug: Run Nearest Test' })

    vim.keymap.set('n', '<leader>dq', function()
      require('dapui').close()
    end, { desc = 'Debug: [Q]uit/Close UI' })

    vim.keymap.set('n', '<leader>dx', function()
      require('dap').terminate() -- Убить процесс
      require('dapui').close() -- Закрыть окна
    end, { desc = 'Debug: e[X]it and close' })
  end,
}
