return {
	"karb94/neoscroll.nvim",
	    opts = {
		 mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
		    '<C-u>', '<C-d>',
		    '<C-b>', '<C-f>',
		    '<C-y>', '<C-e>',
		    'zt', 'zz', 'zb',
		  },
	      hide_cursor = true,          -- Hide cursor while scrolling
	      stop_eof = true,             -- Stop at <EOF> when scrolling downwards
	      respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	      duration_multiplier = 2.0,   -- Global duration multiplier
	      easing = 'linear',        -- Default easing function
	      pre_hook = nil,              -- Function to run before the scrolling animation starts
	      post_hook = nil,             -- Function to run after the scrolling animation ends
	      performance_mode = false,    -- Disable "Performance Mode" on all buffers.
	      ignored_events = {           -- Events ignored while scrolling
		  'WinScrolled', 'CursorMoved'
	      }
	},
}
