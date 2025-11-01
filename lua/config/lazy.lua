-- ========================================================================
-- LAZY.NVIM PLUGIN MANAGER
-- ========================================================================
-- Bootstrap and configure lazy.nvim
-- Plugins are organized in:
--   lua/plugins/core/      - Always loaded (UI, editor, git, completion)
--   lua/plugins/lsp/       - LSP infrastructure
--   lua/plugins/lang/      - Language-specific (lazy-loaded by filetype)
-- ========================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Configure and load plugins
require('lazy').setup({
  -- Import all plugins from the new modular structure
  { import = 'plugins.core' },     -- Core plugins (always loaded)
  { import = 'plugins.lsp' },      -- LSP configuration
  { import = 'plugins.lang' },     -- Language-specific plugins (lazy-loaded)
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
