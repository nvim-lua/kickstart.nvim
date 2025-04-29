-- We do some overrides for Kickstart configs here
-- to avoid conflicts from the upstream in the future.
-- require('conform').format_on_save = false

-- require('treesitter.configs').opts.ensure_installed = {
--   'bash',
--   'c',
--   'diff',
--   'html',
--   'lua',
--   'luadoc',
--   'markdown',
--   'markdown_inline',
--   'query',
--   'vim',
--   'vimdoc',
--   'php',
--   'javascript',
--   'html',
--   'css',
-- }

vim.api.nvim_create_user_command('Logs', ':e /tmp/ts_d', {})

vim.api.nvim_create_user_command('Fixtabs', ':set tabstop=4', {})

return {} -- This feels pretty dumb
