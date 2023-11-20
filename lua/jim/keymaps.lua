----------------------
-- EXPERIMENTS:
----------------------
-- date
vim.keymap.set({ 'i', 'v' }, ':w<CR>', '<esc>:w<CR>',
  { desc = "Write File, in insert modde", silent = false })

----------------------
-- [[ Basic Keymaps ]]
----------------------
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'q', '<Nop>', { desc = "<nop>", silent = true })



--------------------------
-- EXPERIMENTAL
--------------------------
local map = vim.keymap.set
-- not working
map(
  "n",
  "<Leader>cd",
  "<Cmd>cd! %:h<CR>",
  { desc = "cd to current buffer path" }
)

-- works
map("n", "<Leader>..", "<Cmd>cd! ..<CR>", { desc = "cd up a level" })
--------------------------
--------------------------



-- REF: https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
-- By default, action dd stores in reg ??
-- If you then dd on blank line "" replaces content in reg ??
-- So, if dd action holds content:  keep it (don't replace)
-- if dd action holds BLANK LINE:  sent to black hole _dd (discard it)
vim.keymap.set("n", "dd", function()
  if vim.fn.getline(".") == "" then return '"_dd' end
  return "dd"
end, { expr = true })



local telescope_home = function()
  require('telescope.builtin').find_files({ cwd = "/home/jim", hidden = true })
end

-- telescope - fails
-- vim.keymap.set('n', '<leader > fz', function() builtin.find_files({ cwd = '/home/jim/' }) end, {})
vim.keymap.set('n', '<leader>fz', telescope_home, { desc = 'Telescope file_files in home directory' })


-- vim.keymap.set( {'n', '<leader>]nc',
-- Remap for dealing with word wrap
-- jr 2023-10-07 Not cause of sticky line
--vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move Up, center' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move Down, center' })

--  vim.keymap.set('n', '<leader>ck', ':e ~/.config/kickstart/init.lua<CR>', { desc = 'Config Kickstart' })
vim.keymap.set('n', '<leader>bw', 'i**<esc>Ea**<esc>w', { desc = "[B]old [W]ord" })
--  insert # --------...
vim.keymap.set("n", "<leader>ic", "yypVr-I# <ESC>", { desc = "[ic]insert comment line" })

---------------------
-- Diagnostic keymaps
---------------------
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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
  show_help = true, -- (default) show a help message in the command line for using WhichKey
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPACE",
    ["n"] = "notes",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
}
local mappings = {
  -- g is an experiment and duplicates done elsewhere
  g = {
    name = "temp file",
    -- checkhealth, gb, gc are conflicts
    q = { "<cmd>q<cr>", 'Quit - no warn' },
  },
  f = {
    name = "find things & Telescope",
    f = { "<cmd>Telescope find_files<cr>", "Telescope | Find File" }, -- create a binding with label
    g = { "<cmd>Telescope live_grep<cr>", "Telescope | Full Text Search" },
    b = { "<cmd>Telescope buffers<cr>", "Telescope [B]uffers" },
    -- tz is conflict
    -- fails
    --
    -- z = { "<cmd>Telescope find_files<cr>", "Find File", desc = "Search Home", { cwd = '/home/jim' } }, -- create a binding with label
    -- gb taken by comments plugin
  },
  n = {
    name = "my notes",
    a = { "<cmd>cd ~/code/docs/ALZ/<cr>", "cd [A]LZ [Notes]" },
    m = { "<cmd>e ~/code/docs/tech_notes/500_ML_Notes.qmd<cr>", "[M]L [Notes]" },
    h = { "<cmd>e ~/code/docs/health_notes/medical_notes.qmd<cr>",
      "[H]ealth [Notes]" },
    o = { "<cmd>cd ~/code/docs/misc_files/<cr>", "cd Misc Notes" },
    t = { "<cmd>e ~/code/docs/tech_notes/300_tech_notes.qmd<cr>", "[T]ech [Notes]" },
    --vim.keymap.set('n', '<leader>tn', ':e ~/code/docs/tech_notes/300_tech_notes.qmd<CR>', { desc = 'Tech Notes' })
    --vim.keymap.set('n', '<leader>mln', ':e ~/code/docs/tech_notes/500_ML_Notes.qmd<CR>', { desc = 'ML Notes' })
  },
  r = {
    name = "extra R cmds",
    sx = { "<cmd>RStop<CR>", "interrupt R, RStop" },
    x = { "<cmd>RStop<CR>", "interrupt R, RStop" },
  },
  t = {
    name = "not in use",
  },

  q = { ":q<cr>", "Quit - no warn" },
  Q = { ":wq<cr>", "Save & Quit" },
  w = { ":w<cr>", "Save" },
  x = { ":bdelete<cr>", "Close" },
  -- use :RKill to stop R, close terminal (not guaranteed)
  z1 = { '<C-W>p', 'other window' },
  z2 = { '<C-W>pAjunk<esc>', 'other window junk' },
  rk = { ':RKill<CR>', 'RKill , but not guaranteed to close terminal' },
  -- use <leader>ck  E = { ':e ~/.config/kickstart/init.lua<cr>', 'Edit KICKSTART config' },
  ck = { ':e ~/.config/kickstart/init.lua<cr>', '[ck] Edit KICKSTART config' },
}

local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
-- }}}
