return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  dependencies = {
    'github/copilot.vim',
  },
  build = ':Copilot auth',
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  },
  config = function()
    -- vim.cmd [[
    --   nnoremap <silent> <leader>cp :Copilot<CR>
    --   nnoremap <silent> <leader>cs :CopilotSend<CR>
    --   nnoremap <silent> <leader>cr :CopilotReset<CR>
    --   nnoremap <silent> <leader>cc :CopilotClear<CR>
    --   nnoremap <silent> <leader>cd :CopilotDisable<CR>
    --   nnoremap <silent> <leader>ce :CopilotEnable<CR>
    --   nnoremap <silent> <leader>ct :CopilotToggle<CR>
    -- ]]

    -- vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
  end,
}
