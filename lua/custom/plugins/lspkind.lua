return {
  'onsails/lspkind.nvim',
  config = function ()

	local lspkind = require'lspkind'

	-- nvim-cmp setup
	local cmp = require 'cmp'
	cmp.setup {
	  formatting = {
		format = lspkind.cmp_format({
		  mode = 'symbol_text', -- show only symbol annotations
		  maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		  ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

		  -- The function below will be called before any actual modifications from lspkind
		  -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
		  before = function (entry, vim_item)
			return vim_item
		  end
		})
	  }
	}
  end
}

