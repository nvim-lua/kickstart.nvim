return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local util = require 'gitsigns.util'
      require('gitsigns').setup {
        -- --- ТВОИ НАСТРОЙКИ ВИЗУАЛА (оставляем как было) ---
        watch_gitdir = { interval = 1000, follow_files = true },
        attach_to_untracked = true,
        current_line_blame = true, -- Блейм включен по умолчанию
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'right_align',
          delay = 500,
        },
        -- Твой кастомный форматтер блейма
        current_line_blame_formatter = function(_, info)
          return {
            { '|| ', '@lsp.type.variable' },
            { info.author, '@lsp.type.comment' },
            { ' • ', '@lsp.type.variable' },
            { util.expand_format('<author_time:%R>', info), '@lsp.type.operator' },
            { ' • ', '@lsp.type.variable' },
            { info.summary or '', '@lsp.type.string' },
          }
        end,
        preview_config = {
          border = 'rounded',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },

        -- --- ВОТ ЧЕГО НЕ ХВАТАЛО: КЛАВИШИ УПРАВЛЕНИЯ ---
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Навигация (переход к следующему изменению)
          map('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Jump to next hunk' })

          map('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Jump to previous hunk' })

          -- Действия (Actions)
          map('n', '<leader>hs', gs.stage_hunk, { desc = 'Git: [S]tage Hunk' }) -- Добавить кусок в индекс
          map('n', '<leader>hr', gs.reset_hunk, { desc = 'Git: [R]eset Hunk' }) -- Откатить кусок
          map('v', '<leader>hs', function()
            gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'Git: Stage selection' })
          map('v', '<leader>hr', function()
            gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'Git: Reset selection' })

          map('n', '<leader>hS', gs.stage_buffer, { desc = 'Git: [S]tage Buffer' }) -- Добавить весь файл
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Git: [U]ndo Stage Hunk' }) -- Убрать из индекса последний кусок

          map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git: [P]review Hunk' }) -- Показать превью изменений

          map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Git: [T]oggle [B]lame line' }) -- Вкл/Выкл блейм
          map('n', '<leader>hd', gs.diffthis, { desc = 'Git: [D]iff against index' }) -- Показать diff
        end,
      }
    end,
  },
}
