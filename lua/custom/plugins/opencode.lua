return {
  'nickjvandyke/opencode.nvim',
  version = '*', -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      'folke/snacks.nvim',
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...) return require('opencode').snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    local layout = require 'custom.layout'

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require('opencode.terminal').open('opencode --port', {
            split = 'right',
            width = math.max(40, math.floor(vim.o.columns * 0.4)),
          })
        end,
        stop = function() require('opencode.terminal').close() end,
        toggle = function()
          require('opencode.terminal').toggle('opencode --port', {
            split = 'right',
            width = math.max(40, math.floor(vim.o.columns * 0.4)),
          })
        end,
      },
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ 'n', 'x' }, '<C-a>', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode…' })
    vim.keymap.set({ 'n', 'x' }, '<C-x>', function() require('opencode').select() end, { desc = 'Execute opencode action…' })
    vim.keymap.set({ 'n', 't' }, '<C-.>', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })

    vim.keymap.set({ 'n', 'x' }, 'go', function() return require('opencode').operator '@this ' end, { desc = 'Add range to opencode', expr = true })
    vim.keymap.set('n', 'goo', function() return require('opencode').operator '@this ' .. '_' end, { desc = 'Add line to opencode', expr = true })

    vim.keymap.set('n', '<S-C-u>', function() require('opencode').command 'session.half.page.up' end, { desc = 'Scroll opencode up' })
    vim.keymap.set('n', '<S-C-d>', function() require('opencode').command 'session.half.page.down' end, { desc = 'Scroll opencode down' })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local argv = vim.fn.argv()
        local first_arg = argv[1]
        if vim.fn.argc() == 1 and type(first_arg) == 'string' and vim.fn.isdirectory(first_arg) == 1 then
          vim.schedule(function()
            layout.focus_main_window()
            require('opencode').toggle()
            layout.focus_main_window()
          end)
        end
      end,
    })
  end,
}
