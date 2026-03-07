return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
      file_types = { 'markdown' },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    init = function()
      local browser = ''
      local is_macos = vim.fn.has('macunix') == 1

      if is_macos then
        vim.cmd([[
          function! OpenMarkdownPreview(url) abort
            execute 'silent !open ' . shellescape(a:url)
          endfunction
        ]])
      elseif vim.fn.executable('google-chrome-stable') == 1 then
        browser = 'google-chrome-stable'
      elseif vim.fn.executable('google-chrome') == 1 then
        browser = 'google-chrome'
      elseif vim.fn.executable('chromium') == 1 then
        browser = 'chromium'
      end

      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_browser = browser
      vim.g.mkdp_browserfunc = is_macos and 'OpenMarkdownPreview' or ''
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    keys = {
      { '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', desc = '[M]arkdown [P]review' },
    },
  },
}
