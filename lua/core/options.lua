-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load Nix-controlled settings if available
pcall(require, 'nix-settings')

-- Place custom vim options here

-- Set based on your font installation
vim.g.have_nerd_font = true

-- [[ Essential Options from Kickstart ]]
-- These MUST be set since we're not loading kickstart's defaults

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse and interaction
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.showmode = false -- Don't show mode since we have a statusline

-- Clipboard - sync with system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Indentation settings
vim.opt.breakindent = true -- Enable break indent
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Save undo history
vim.opt.undofile = true

-- Search settings
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smartcase = true -- Unless capital in search
vim.opt.hlsearch = true -- Highlight search results

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Function to check if running in a shared tmux session
local function is_shared_tmux_session()
  if not vim.env.TMUX then
    return false
  end
  
  local handle = io.popen('tmux list-sessions -F "#{session_name}:#{session_attached}" 2>/dev/null')
  if not handle then
    return false
  end
  
  local current_session = vim.fn.system('tmux display-message -p "#S"'):gsub('\n', '')
  local output = handle:read('*a')
  handle:close()
  
  -- Check if session name contains "shared" (case insensitive)
  if current_session:lower():find('shared') then
    return true
  end
  
  -- Also check if multiple users are attached
  for line in output:gmatch('[^\r\n]+') do
    local session_name, attached_count = line:match('([^:]+):(%d+)')
    if session_name == current_session and tonumber(attached_count) > 1 then
      return true
    end
  end
  
  return false
end

-- Warn before quitting if in a shared tmux session
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    if is_shared_tmux_session() then
      local choice = vim.fn.confirm(
        'You are in a shared tmux session. Other users may be affected.\nDo you really want to quit?',
        '&Yes\n&No',
        2  -- Default to No
      )
      -- vim.fn.confirm returns 1 for Yes, 2 for No, 0 for Esc
      -- The & makes Y/y and N/n work as shortcuts (case-insensitive)
      if choice ~= 1 then
        return  -- Prevent quit unless explicitly choosing Yes
      end
    end
  end,
})

