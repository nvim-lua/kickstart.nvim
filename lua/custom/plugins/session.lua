-- ========================================================================
-- SESSION MANAGEMENT - Auto-save and restore your workspace
-- ========================================================================
--
-- This plugin automatically saves your session (open files, window layout,
-- buffers, etc.) when you quit Neovim and restores it when you reopen
-- the same directory.
--
-- Features:
--   - ✅ Auto-saves session on exit (automatically!)
--   - ✅ Auto-restores session when you `cd` into a directory and run `nvim`
--   - Saves per-directory (each project has its own session)
--   - Saves open buffers, window splits, cursor positions, and more
--
-- IMPORTANT: Auto-restore works when you:
--   1. cd /path/to/your/project
--   2. nvim (without specifying files)
--   
-- If you open a specific file (e.g., `nvim main.dart`), auto-restore is skipped.
-- Use manual restore (<leader>Sr) if needed.
--
-- Keymaps:
--   <leader>Ss - Save session manually
--   <leader>Sr - Restore session manually (if auto-restore didn't trigger)
--   <leader>Sd - Delete session for current directory
--   <leader>Sf - Find/search all sessions (Telescope)
--
-- Quit keymaps (in init.lua, integrated with auto-session):
--   <leader>Qa - Quit all and save session (most common)
--   <leader>Qq - Force quit all without saving (no session save)
--   <leader>Qw - Save all files, save session, then quit
--
-- WORKFLOW:
--   1. cd into your project directory
--   2. nvim (session auto-restores if it exists!)
--   3. Work on your project
--   4. Quit with <leader>Qa or just :qa (auto-saves!)
--   5. Next time: repeat from step 1 - your workspace is restored!
--
-- Sessions are saved in: ~/.local/share/nvim/sessions/
-- ========================================================================

return {
  'rmagatti/auto-session',
  lazy = false, -- Load on startup to restore session
  opts = {
    -- Session save/restore options
    auto_session_enabled = true, -- Automatically save sessions on exit
    auto_restore_enabled = true, -- Automatically restore sessions on startup
    auto_save_enabled = true, -- Auto-save session on exit
    auto_session_suppress_dirs = { '~/', '~/Downloads', '/' }, -- Don't save sessions in these dirs
    auto_session_use_git_branch = false, -- One session per directory (not per git branch)
    
    -- What to save in the session
    auto_session_enable_last_session = false, -- Don't restore last session if not in a project
    auto_session_create_enabled = true, -- Auto-create session on first save
    
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
    -- Manual session control (Capital S to avoid conflict with search)
    {
      '<leader>Ss',
      '<cmd>AutoSession save<cr>',
      desc = '[S]ession: [S]ave',
    },
    {
      '<leader>Sr',
      '<cmd>AutoSession restore<cr>',
      desc = '[S]ession: [R]estore',
    },
    {
      '<leader>Sd',
      '<cmd>AutoSession delete<cr>',
      desc = '[S]ession: [D]elete',
    },
    {
      '<leader>Sf',
      '<cmd>AutoSession search<cr>',
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
