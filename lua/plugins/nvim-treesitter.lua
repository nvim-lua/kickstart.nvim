return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = function()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()
    -- Install C++ parser explicitly to avoid tarball issues
    vim.cmd('silent! TSInstall cpp')
  end,
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    -- List of languages to ensure are installed
    ensure_installed = {
      'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc',
      'markdown', 'markdown_inline', 'python', 'rust',
      'javascript', 'typescript', 'json', 'yaml', 'query',
      'vim', 'vimdoc', 'comment', 'regex'
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    -- List of parsers to ignore installing (for "all")
    ignore_install = { 'phpdoc' },

    highlight = {
      enable = true,
      -- Additional filetypes to enable highlighting for
      additional_vim_regex_highlighting = { 'ruby' },
      -- Disable for large files
      disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = { 
      enable = true, 
      disable = { 'ruby', 'yaml' } 
    },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
