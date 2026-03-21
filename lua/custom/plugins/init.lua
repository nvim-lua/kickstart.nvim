-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.keymap.set('n', 'x', '"_x') -- Delete without yanking
vim.keymap.set('n', '<leader>pv', ':Ex<CR>') -- Open file explorer

-- Windows specific stuff:
vim.keymap.set('n', '½', '$') -- Move to end of line in normal mode
vim.keymap.set('v', '½', '$') -- Move to end of line in visual mode
vim.keymap.set('o', '½', '$') -- operator-pending mode to end of line

vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.cmdheight = 1
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '120'
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5
vim.opt.background = 'dark'
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'

vim.g.vimwiki_list = {
  { path = '~/Jottacloud/vimwiki' },
}

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
-- #vim.g.copilot_no_tab_map = true
--

-- Windows specific stuff:
if vim.fn.has 'wsl' == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw))',
    },
    cache_enabled = 0,
  }
end

return {
  'vimwiki/vimwiki',
  'brenoprata10/nvim-highlight-colors', -- highlight colors in files
  'github/copilot.vim',

  -- Configure Telescope to allow buffer deletion
  {
    'nvim-telescope/telescope.nvim',
    opts = function(_, opts)
      local actions = require 'telescope.actions'

      -- Ensure pickers table exists
      opts.pickers = opts.pickers or {}

      -- Configure buffers picker with deletion mapping
      -- Note: <C-x> conflicts with horizontal split, so we use <C-q> instead
      -- <C-d> conflicts with preview scroll down
      -- dd doesn't work because Telescope doesn't support multi-key sequences in normal mode
      opts.pickers.buffers = {
        mappings = {
          i = {
            ['<C-q>'] = actions.delete_buffer, -- Recommended: no conflicts
          },
          n = {
            ['d'] = actions.delete_buffer, -- Single 'd' key (simple and works)
            ['<C-q>'] = actions.delete_buffer,
          },
        },
      }

      return opts
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.typescript = { 'prettierd', 'prettier', stop_after_first = true }
      opts.formatters_by_ft.typescriptreact = { 'prettierd', 'prettier', stop_after_first = true }
      opts.formatters_by_ft.javascriptreact = { 'prettierd', 'prettier', stop_after_first = true }
      return opts
    end,
  },
}
