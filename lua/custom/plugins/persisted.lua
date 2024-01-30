--
-- better session management with git branch support
--

local M = {
  'olimorris/persisted.nvim',
  lazy = false,
}

function M.config()
  require('persisted').setup({
    save_dir = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'), -- directory where session files are saved: Resolves to ~/.local/share/lvim/sessions/
    silent = false,                                                   -- silent nvim message when sourcing session file
    use_git_branch = true,                                            -- create session files based on the branch of the git enabled repository
    autosave = true,                                                  -- automatically save session files when exiting Neovim
    should_autosave = function()                                      -- function to determine if a session should be autosaved
      -- do not autosave if the current filetype is ""(empty buffer), NvimTree or alpha
      if vim.bo.filetype == '' or vim.bo.filetype == 'NvimTree' or vim.bo.filetype == 'alpha' then
        return false
      end
      return true
    end,
    autoload = true,                    -- automatically load the session for the cwd on Neovim startup
    on_autoload_no_session = function() -- function to run when `autoload = true` but there is no session to load
    end,
    follow_cwd = true,                  -- change session file name to match current working directory if it changes
    allowed_dirs = {
      '~/Flexfiles',
      '~/projects',
      '~/work',
    },                                    -- table of dirs that the plugin will auto-save and auto-load from
    ignored_dirs = nil,                   -- table of dirs that are ignored when auto-saving and auto-loading
    telescope = {                         -- options for the telescope extension
      reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
    },
  })
end

-- persisted autocommands
local persistedGroup = vim.api.nvim_create_augroup('PersistedHooks', { clear = true })

-- close NvimTree and DiffView(git) before saving session
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'PersistedSavePre',
  group = persistedGroup,
  callback = function()
    pcall(vim.cmd, 'NvimTreeClose')
    pcall(vim.cmd, 'DiffviewClose')
  end,
})
-- close empty buffers before saving session
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'PersistedSavePre',
  group = persistedGroup,
  callback = function()
    local buflist = vim.fn.getbufinfo({ buflisted = 1 })
    for _, buf in ipairs(buflist) do
      if buf.name == '' then
        vim.api.nvim_buf_delete(buf.bufnr, { force = false })
      end
    end
  end,
})

return M
