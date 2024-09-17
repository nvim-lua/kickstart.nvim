local M = {}

-- Function to create a new personal note
function M.new_personal_note()
  vim.cmd 'ObsidianWorkspace personal'
  vim.cmd 'ObsidianNew'
end

-- Function to create a new work note
function M.new_work_note()
  vim.cmd 'ObsidianWorkspace work'
  vim.cmd 'ObsidianNew'
end

-- Function to create a new daily note
function M.new_daily_note()
  vim.cmd 'ObsidianWorkspace daily'
  vim.cmd 'ObsidianToday'
end

-- Function to follow back Link
function M.followLink()
  vim.cmd 'ObsidianFollowLink'
end

-- Set up key mappings
function M.setup_keymaps()
  vim.api.nvim_set_keymap(
    'n',
    '<leader>np',
    '<cmd>lua require("obsidian_keymaps").new_personal_note()<CR>',
    { noremap = true, silent = true, desc = 'New [P]ersonal note' }
  )
  vim.api.nvim_set_keymap(
    'n',
    '<leader>nw',
    '<cmd>lua require("obsidian_keymaps").new_work_note()<CR>',
    { noremap = true, silent = true, desc = 'New [W]ork note' }
  )
  vim.api.nvim_set_keymap(
    'n',
    '<leader>nd',
    '<cmd>lua require("obsidian_keymaps").new_daily_note()<CR>',
    { noremap = true, silent = true, desc = 'New [D]aily note' }
  )
  vim.api.nvim_set_keymap('n', '<leader>nf', '<cmd>lua require("obsidian_keymaps").followLink()<CR>', { noremap = true, silent = true, desc = '[F]ollow Link' })
end

return M
