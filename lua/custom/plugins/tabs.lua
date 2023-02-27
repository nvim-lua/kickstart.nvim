-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	-- NOTE: Yes, you can install new plugins here!
	'romgrk/barbar.nvim',
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- Move to previous/next
		map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
		map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
		-- Re-order to previous/next
		map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
		map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
		-- Goto buffer in position...
		map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
		map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
		map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
		map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
		map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
		map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
		map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
		map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
		map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
		map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
		-- Pin/unpin buffer
		map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
		-- Close buffer
		map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
		-- Wipeout buffer
		--                 :BufferWipeout
		-- Close commands
		--                 :BufferCloseAllButCurrent
		--                 :BufferCloseAllButPinned
		--                 :BufferCloseAllButCurrentOrPinned
		--                 :BufferCloseBuffersLeft
		--                 :BufferCloseBuffersRight
		-- Magic buffer-picking mode
		map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
		-- Sort automatically by...
		map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
		map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
		map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
		map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
	end,
	opts = {
		-- Enable/disable animations
		animation = true,

		-- Enable/disable auto-hiding the tab bar when there is a single buffer
		auto_hide = false,

		-- Enable/disable current/total tabpages indicator (top right corner)
		tabpages = true,

		-- Enable/disable close button
		closable = true,

		-- Enables/disable clickable tabs
		--  - left-click: go to buffer
		--  - middle-click: delete buffer
		clickable = true,

		-- Enables / disables diagnostic symbols
		diagnostics = {
			-- you can use a list
			{ enabled = true, icon = 'ﬀ' }, -- ERROR
			{ enabled = false }, -- WARN
			{ enabled = false }, -- INFO
			{ enabled = true }, -- HINT

			-- OR `vim.diagnostic.severity`
			[vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
			[vim.diagnostic.severity.WARN] = { enabled = false },
			[vim.diagnostic.severity.INFO] = { enabled = false },
			[vim.diagnostic.severity.HINT] = { enabled = true },
		},

		-- Excludes buffers from the tabline
		exclude_ft = { 'javascript' },
		exclude_name = { 'package.json' },

		-- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
		hide = { extensions = true, inactive = true },

		-- Disable highlighting alternate buffers
		highlight_alternate = false,

		-- Disable highlighting file icons in inactive buffers
		highlight_inactive_file_icons = false,

		-- Enable highlighting visible buffers
		highlight_visible = true,

		-- Enable/disable icons
		-- if set to 'numbers', will show buffer index in the tabline
		-- if set to 'both', will show buffer index and icons in the tabline
		icons = true,

		-- If set, the icon color will follow its corresponding buffer
		-- highlight group. By default, the Buffer*Icon group is linked to the
		-- Buffer* group (see Highlighting below). Otherwise, it will take its
		-- default value as defined by devicons.
		icon_custom_colors = false,

		-- Configure icons on the bufferline.
		icon_separator_active = '▎',
		icon_separator_inactive = '▎',
		icon_close_tab = '',
		icon_close_tab_modified = '●',
		icon_pinned = '車',

		-- If true, new buffers will be inserted at the start/end of the list.
		-- Default is to insert after current buffer.
		insert_at_end = false,
		insert_at_start = false,

		-- Sets the maximum padding width with which to surround each tab
		maximum_padding = 1,

		-- Sets the minimum padding width with which to surround each tab
		minimum_padding = 1,

		-- Sets the maximum buffer name length.
		maximum_length = 30,

		-- If set, the letters for each buffer in buffer-pick mode will be
		-- assigned based on their name. Otherwise or in case all letters are
		-- already assigned, the behavior is to assign letters in order of
		-- usability (see order below)
		semantic_letters = true,

		-- New buffer letters are assigned in this order. This order is
		-- optimal for the qwerty keyboard layout but might need adjustement
		-- for other layouts.
		letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

		-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
		-- where X is the buffer number. But only a static string is accepted here.
		no_name_title = nil,
	}
}
