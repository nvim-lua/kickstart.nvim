
return {
  'mrjones2014/op.nvim',
  version = "*",
  config = function ()
	require('op').setup({
	  -- you can change this to a full path if `op`
	  -- is not on your $PATH
	  op_cli_path = 'op',
	  -- Whether to sign in on start.
	  signin_on_start = false,
	  -- show NerdFont icons in `vim.ui.select()` interfaces,
	  -- set to false if you do not use a NerdFont or just
	  -- don't want icons
	  use_icons = true,
	  -- command to use for opening URLs,
	  -- can be a function or a string
	  url_open_command = function()
		if vim.fn.has('mac') == 1 then
		  return 'open'
		elseif vim.fn.has('unix') == 1 then
		  return 'xdg-open'
		end
		return nil
	  end,
	  -- settings for op.nvim sidebar
	  sidebar = {
		-- sections to include in the sidebar
		sections = {
		  favorites = true,
		  secure_notes = true,
		},
		-- sidebar width
		width = 40,
		-- put the sidebar on the right or left side
		side = 'right',
		-- keymappings for the sidebar buffer.
		-- can be a string mapping to a function from
		-- the module `op.sidebar.actions`,
		-- an editor command string, or a function.
		-- if you supply a function, a table with the following
		-- fields will be passed as an argument:
		-- {
		--   title: string,
		--   icon: string,
		--   type: 'header' | 'item'
		--   -- data will be nil if type == 'header'
		--   data: nil | {
		--       uuid: string,
		--       vault_uuid: string,
		--       category: string,
		--       url: string
		--     }
		-- }
		mappings = {
		  -- if it's a Secure Note, open in op.nvim's Secure Notes editor;
		  -- if it's an item with a URL, open & fill the item in default browser;
		  -- otherwise, open in 1Password 8 desktop app
		  ['<CR>'] = 'default_open',
		  -- open in 1Password 8 desktop app
		  ['go'] = 'open_in_desktop_app',
		  -- edit in 1Password 8 desktop app
		  ['ge'] = 'edit_in_desktop_app',
		},
	  },
	  -- Custom formatter function for statusline component
	  statusline_fmt = function(account_name)
		if not account_name or #account_name == 0 then
		  return '> 1Password: No active session'
		end

		return string.format('> 1Password: %s', account_name)
	  end
	  -- global_args accepts any arguments
	  -- listed under "Global Flags" in
	  -- `op --help` output.
    })
  end,  
}
