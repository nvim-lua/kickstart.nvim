-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "*",
-- 	group = "UserDefLoadOnce",
-- 	desc = "prevent colorscheme clears self-defined DAP icon colors.",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
-- 		vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
-- 		vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })
-- 	end
-- })

vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='🟨', texthl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='🟥', texthl='DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='🪵', texthl='DapLogPoint' })

vim.cmd('highlight MyRedBackground ctermbg=black guibg=black')
vim.fn.sign_define('DapStopped', { text='▶️', texthl='', linehl='MyRedBackground', numhl='' })


return {
  'mfussenegger/nvim-dap-python',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  config = function ()
    require('dap-python').setup('~/.venvs_python/debugpy/bin/python')
  end
}
