----------------------
-- [[ Basic Keymaps ]]
----------------------
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'q', '<Nop>', { silent = true })

-- REF: https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
-- if dd action holds content:  keep it
-- if dd action holds BLANK LINE:  sent to black hole _dd
vim.keymap.set("n", "dd", function()
  if vim.fn.getline(".") == "" then return '"_dd' end
  return "dd"
end, { expr = true })

-- vim.keymap.set( {'n', '<leader>]nc',
-- Remap for dealing with word wrap
-- jr 2023-10-07 Not cause of sticky line
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move Up, center' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move Down, center' })

--  vim.keymap.set('n', '<leader>ck', ':e ~/.config/kickstart/init.lua<CR>', { desc = 'Config Kickstart' })
vim.keymap.set('n', '<leader>tn', ':e ~/code/docs/tech_notes/300_tech_notes.qmd<CR>', { desc = 'Tech Notes' })
vim.keymap.set('n', '<leader>mln', ':e ~/code/docs/tech_notes/500_ML_Notes.qmd<CR>', { desc = 'ML Notes' })
vim.keymap.set('n', '<leader>bw', 'i**<esc>Ea**<esc>w', { desc = "[B]old [W]ord" })
--  insert # --------...
vim.keymap.set("n", "<leader>ic", "yypVr-I# <ESC>", { desc = "[ic]insert comment line" })

------------------------------------------------------
--             which-key
------------------------------------------------------
--             experiment; add my keymaps to which-key
--             stolen:  REF: https://github.com/hackorum/nfs/blob/master/lua/whichkey-config/init.lua
------------------------------------------------------
--{{{
local wk = require 'which-key'
wk.setup {
  plugins = {
    marks = false,
    registers = true,
    spelling = { enabled = false, suggestions = 20 },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      --      z = false,
      g = false,
    },
  },
}
local mappings = {
  -- g is an experiment and duplicates done elsewhere
  g = {
    name = "temp file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
    g = { "<cmd>Telescope live_grep<cr>", "Full Text Search" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    q = { "<cmd>q<cr>", 'Quit - no warn' },
  },
  t = {
    name = "telescope",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },                                          -- create a binding with label
    z = { "<cmd>Telescope find_files<cr>", "Find File", desc = "Search Home", pwd = '/home/jim' }, -- create a binding with label
  },

  q = { ':q<cr>', 'Quit - no warn' },
  Q = { ':wq<cr>', 'Save & Quit' },
  w = { ':w<cr>', 'Save' },
  x = { ':bdelete<cr>', 'Close' },
  -- use :RKill to stop R, close terminal (not guaranteed)
  z1 = { '<C-W>p', 'other window' },
  z2 = { '<C-W>pAjunk<esc>', 'other window junk' },
  rk = { ':RKill<CR>', 'RKill , but not guaranteed to close terminal' },
  -- use <leader>ck  E = { ':e ~/.config/kickstart/init.lua<cr>', 'Edit KICKSTART config' },
  ck = { ':e ~/.config/kickstart/init.lua<cr>', '[ck] Edit KICKSTART config' },
  --  f = { ":Telescope find_files<cr>", "Telescope Find Files" },
  --   r = { ":Telescope live_grep<cr>", "Telescope Live Grep" },
}
local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
-- }}}
