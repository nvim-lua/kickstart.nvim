--[[
  Which-key configuration
  
  This file contains the configuration for which-key,
  organizing keybindings into logical groups with descriptions.
]]

---@diagnostic disable-next-line: undefined-global
local vim = vim
local M = {}

function M.setup()
  -- Check if which-key is available
  local status_ok, wk = pcall(require, 'which-key')
  if not status_ok then
    return
  end

  -- Use the modern which-key v3 API with add()
  -- Define common keybindings and groups
  wk.add {
    -- Most frequent operations
    { '<leader>w', '<cmd>w<CR>', desc = 'Save file' },
    { '<leader>q', '<cmd>q<CR>', desc = 'Quit' },
    { '<leader>Q', '<cmd>qa!<CR>', desc = 'Force quit all' },
    { '<leader>/', '<cmd>nohlsearch<CR>', desc = 'Clear highlights' },
    { '<leader>e', '<cmd>Explore<CR>', desc = 'Open file explorer' },

    -- File operations (f)
    { '<leader>f', group = 'Find/Files' },
    { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = 'Live grep' },
    { '<leader>fb', '<cmd>Telescope buffers<CR>', desc = 'Find buffers' },
    { '<leader>fr', '<cmd>Telescope oldfiles<CR>', desc = 'Recent files' },

    -- Buffer operations (b)
    { '<leader>b', group = 'Buffers' },
    { '<leader>bb', '<cmd>Telescope buffers<CR>', desc = 'Browse buffers' },
    { '<leader>bd', '<cmd>bd<CR>', desc = 'Delete buffer' },
    { '<leader>bn', '<cmd>bn<CR>', desc = 'Next buffer' },
    { '<leader>bp', '<cmd>bp<CR>', desc = 'Previous buffer' },

    -- Git operations (g)
    { '<leader>g', group = 'Git' },
    { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'Git status' },
    { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'Git commits' },
    { '<leader>gb', '<cmd>Telescope git_branches<CR>', desc = 'Git branches' },

    -- Code operations (c)
    { '<leader>c', group = 'Code/Copilot' },
    { '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', desc = 'Code actions' },
    { '<leader>cf', '<cmd>lua vim.lsp.buf.format()<CR>', desc = 'Format code' },

    -- Harpoon (h)
    { '<leader>h', group = 'Harpoon' },
    { '<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = 'Add file' },
    { '<leader>hh', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = 'Toggle menu' },
    { '<leader>h1', "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", desc = 'File 1' },
    { '<leader>h2', "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", desc = 'File 2' },
    { '<leader>h3', "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", desc = 'File 3' },
    { '<leader>h4', "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", desc = 'File 4' },

    -- LeetCode (l)
    { '<leader>l', group = 'LeetCode' },
    { '<leader>ll', '<cmd>Leet<CR>', desc = 'Open LeetCode' },
    { '<leader>ld', '<cmd>Leet daily<CR>', desc = 'Daily challenge' },
    { '<leader>lr', '<cmd>Leet random<CR>', desc = 'Random problem' },
    { '<leader>ls', '<cmd>Leet submit<CR>', desc = 'Submit solution' },
    { '<leader>lt', '<cmd>Leet test<CR>', desc = 'Test solution' },

    -- Tab operations (t)
    { '<leader>t', group = 'Tabs' },
    { '<leader>tn', '<cmd>tabnew<CR>', desc = 'New tab' },
    { '<leader>tc', '<cmd>tabclose<CR>', desc = 'Close tab' },
    { '<leader>to', '<cmd>tabnew<CR><cmd>Telescope find_files<CR>', desc = 'New tab with file' },
    { '<leader>t1', '1gt', desc = 'Tab 1' },
    { '<leader>t2', '2gt', desc = 'Tab 2' },
    { '<leader>t3', '3gt', desc = 'Tab 3' },
    { '<leader>t4', '4gt', desc = 'Tab 4' },

    -- Window operations (w)
    { '<leader>w', group = 'Windows' },
    { '<leader>wv', '<cmd>vsplit<CR>', desc = 'Split vertically' },
    { '<leader>ws', '<cmd>split<CR>', desc = 'Split horizontally' },
    { '<leader>wq', '<C-w>q', desc = 'Close window' },
    { '<leader>wo', '<C-w>o', desc = 'Close other windows' },
    { '<leader>wh', '<C-w>h', desc = 'Go to left window' },
    { '<leader>wj', '<C-w>j', desc = 'Go to lower window' },
    { '<leader>wk', '<C-w>k', desc = 'Go to upper window' },
    { '<leader>wl', '<C-w>l', desc = 'Go to right window' },

    -- Terminal operations (tt)
    { '<leader>tt', group = 'Terminal' },
    { '<leader>ttt', '<cmd>ToggleTerm<CR>', desc = 'Toggle terminal' },
    { '<leader>ttf', '<cmd>ToggleTerm direction=float<CR>', desc = 'Floating terminal' },
    { '<leader>tth', '<cmd>ToggleTerm size=10 direction=horizontal<CR>', desc = 'Horizontal terminal' },
    { '<leader>ttv', '<cmd>ToggleTerm size=80 direction=vertical<CR>', desc = 'Vertical terminal' },

    -- Trouble/Diagnostics (x)
    { '<leader>x', group = 'Diagnostics/Trouble' },
    { '<leader>xx', '<cmd>TroubleToggle<CR>', desc = 'Toggle Trouble' },
    { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace diagnostics' },
    { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Document diagnostics' },
    { '<leader>xq', '<cmd>TroubleToggle quickfix<CR>', desc = 'Quickfix list' },
    { '<leader>xl', '<cmd>TroubleToggle loclist<CR>', desc = 'Location list' },

    -- Neorg (n)
    { '<leader>n', group = 'Neorg' },
    { '<leader>ni', '<cmd>Neorg index<CR>', desc = 'Index' },
    { '<leader>nr', '<cmd>Neorg return<CR>', desc = 'Return' },
    { '<leader>nt', '<cmd>Neorg toggle-concealer<CR>', desc = 'Toggle concealer' },
    { '<leader>nm', '<cmd>Neorg inject-metadata<CR>', desc = 'Inject metadata' },

    -- Neorg Journal (nj)
    { '<leader>nj', group = 'Journal' },
    { '<leader>njj', '<cmd>Neorg journal today<CR>', desc = 'Today' },
    { '<leader>njt', '<cmd>Neorg journal tomorrow<CR>', desc = 'Tomorrow' },
    { '<leader>njy', '<cmd>Neorg journal yesterday<CR>', desc = 'Yesterday' },

    -- Neorg Workspace (nw)
    { '<leader>nw', group = 'Workspace' },
    { '<leader>nwn', '<cmd>Neorg workspace notes<CR>', desc = 'Notes' },
    { '<leader>nww', '<cmd>Neorg workspace work<CR>', desc = 'Work' },
    { '<leader>nwp', '<cmd>Neorg workspace personal<CR>', desc = 'Personal' },

    -- Neorg Export (ne)
    { '<leader>ne', group = 'Export' },
    { '<leader>neh', '<cmd>Neorg export to-html<CR>', desc = 'To HTML' },
    { '<leader>nem', '<cmd>Neorg export to-markdown<CR>', desc = 'To Markdown' },
    { '<leader>nep', '<cmd>Neorg export to-pdf<CR>', desc = 'To PDF' },

    -- Diagnostics navigation
    { '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', desc = 'Previous diagnostic' },
    { ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', desc = 'Next diagnostic' },
  }

  -- Visual mode mappings
  wk.add {
    { '<leader>c', group = 'Code', mode = 'v' },
    { '<leader>cc', "<cmd>'<,'>CommentToggle<CR>", desc = 'Comment selection', mode = 'v' },
    { '<leader>y', '"+y', desc = 'Yank to system clipboard', mode = 'v' },
    { '<leader>p', '"+p', desc = 'Paste from system clipboard', mode = 'v' },
  }

  -- Buffer navigation shortcuts
  wk.add {
    { '<Tab>', '<cmd>bnext<CR>', desc = 'Next buffer' },
    { '<S-Tab>', '<cmd>bprevious<CR>', desc = 'Previous buffer' },
  }
end

return M
