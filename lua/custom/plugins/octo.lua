
return {
  'pwntester/octo.nvim',
  version = "*",  
  dependencies = {
    -- 1Password plugin for Neovim
    'mrjones2014/op.nvim',
    -- another plugin to make the UI a bit nicer
    'stevearc/dressing.nvim',
  },
  config = function ()
	require('octo').setup({
	  gh_env = function()
		-- the 'op.api' module provides the same interface as the CLI
		-- each subcommand accepts a list of arguments
		-- and returns a list of output lines.
		-- use it to retrieve the GitHub access token from 1Password
		local github_token = require('op.api').item.get({ 'GitHub', '--fields', 'token' })[1]
		if not github_token or not vim.startswith(github_token, 'ghp_') then
		  error('Failed to get GitHub token.')
		end

		-- the values in this table will be provided to the
		-- GitHub CLI as environment variables when invoked,
		-- with the table keys (e.g. GITHUB_TOKEN) being the
		-- environment variable name, and the values (e.g. github_token)
		-- being the variable value
		return { GITHUB_TOKEN = github_token }
	  end,
	})
  end,  
}
