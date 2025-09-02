-- Main plugin loader - imports all plugin specifications
return {
  -- UI and Theme
  { import = 'plugins.spec.ui' },
  { import = 'plugins.spec.editor' },
  { import = 'plugins.spec.autopairs' },
  { import = 'plugins.spec.indent-line' },
  
  -- Core functionality
  { import = 'plugins.spec.lsp' },
  { import = 'plugins.spec.treesitter' },
  { import = 'plugins.spec.telescope' },
  { import = 'plugins.spec.blink' },
  
  -- Git integration
  { import = 'plugins.spec.git' },
  
  -- Development tools
  { import = 'plugins.spec.copilot' },
  { import = 'plugins.spec.debug' },
  { import = 'plugins.spec.formatting' },
  
  -- Navigation
  { import = 'plugins.spec.nvim-tmux-navigator' },
}