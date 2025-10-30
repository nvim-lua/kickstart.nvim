-- ========================================================================
-- SESSION MANAGEMENT - Auto-save and restore your workspace
-- ========================================================================
--
-- This plugin automatically saves your session (open files, window layout,
-- buffers, etc.) when you quit Neovim and restores it when you reopen
-- the same directory.
--
-- Features:
--   - Auto-saves session on exit
--   - Auto-restores session when opening Neovim in a directory
--   - Saves per-directory (each project has its own session)
--   - Saves open buffers, window splits, cursor positions, and more
--
-- Keymaps:
--   <leader>ss - Save session manually
--   <leader>sr - Restore session manually
--   <leader>sd - Delete session for current directory
--   <leader>sf - Find/search all sessions (Telescope)
--
-- Quit keymaps (in init.lua):
--   <leader>Qa - Quit all windows
--   <leader>Qq - Force quit all without saving
--   <leader>Qw - Save all and quit
--
-- Sessions are saved in: ~/.local/share/nvim/sessions/
-- ========================================================================

return {
  'rmagatti/auto-session',
  lazy = false, -- Load on startup to restore session
  opts = {
    -- Session save/restore options
    auto_session_enabled = true, -- Automatically save sessions
    auto_restore_enabled = true, -- Automatically restore sessions
    auto_save_enabled = true, -- Auto-save on exit
    auto_session_suppress_dirs = { '~/', '~/Downloads', '/' }, -- Don't save sessions in these dirs
    auto_session_use_git_branch = false, -- One session per directory (not per git branch)
    
    -- What to save in the session
    auto_session_enable_last_session = false, -- Don't restore last session if not in a project
    
    -- Hooks to run before/after session save/restore
    pre_save_cmds = {
      'Neotree close', -- Close Neo-tree before saving session
    },
    post_restore_cmds = {
      -- You can add commands to run after restore here
    },
    
    -- Session lens (Telescope integration for browsing sessions)
    session_lens = {
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = false,
    },
  },
  keys = {
    -- Manual session control
    {
      '<leader>ss',
      '<cmd>SessionSave<cr>',
      desc = '[S]ession: [S]ave',
    },
    {
      '<leader>sr',
      '<cmd>SessionRestore<cr>',
      desc = '[S]ession: [R]estore',
    },
    {
      '<leader>sd',
      '<cmd>SessionDelete<cr>',
      desc = '[S]ession: [D]elete',
    },
    {
      '<leader>sf',
      '<cmd>SessionSearch<cr>',
      desc = '[S]ession: [F]ind/search',
    },
  },
  config = function(_, opts)
    require('auto-session').setup(opts)
    
    -- Register with which-key
    require('which-key').add {
      { '<leader>s', group = '[S]ession' },
      { '<leader>Q', group = '[Q]uit' },
    }
  end,
}
