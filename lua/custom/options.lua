-- Place custom vim options here

-- Set based on your font installation
vim.g.have_nerd_font = true

-- Indentation settings
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Add any other custom vim.o or vim.g settings from your old config here
-- For example, if you changed defaults for:
-- vim.opt.number = true -- (Already default in kickstart)
-- vim.opt.mouse = 'a' -- (Already default in kickstart)
-- etc... Review the options section of your old init.lua and add any *changed* values here.
-- The kickstart defaults are generally sensible, so you might not need many overrides.

-- print 'Custom options loaded!' -- Optional: Add print statement for debugging
