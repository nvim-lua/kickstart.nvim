-- We do some overrides for Kickstart configs here
-- to avoid conflicts from the upstream in the future.

vim.api.nvim_create_user_command('Fixtabs', ':set tabstop=4', {})

return {} -- This feels pretty dumb
