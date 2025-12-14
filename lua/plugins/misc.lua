-- Miscellaneous plugins
return {
  -- Database client
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- Wiki/notes
  {
    'lervag/wiki.vim',
    init = function()
      vim.g.wiki_root = '~/Documents/Developer/'
    end,
  },

  -- Import picker
  {
    'piersolenski/import.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = { picker = 'telescope' },
    keys = {
      { '<leader>i', function() require('import').pick() end, desc = 'Import' },
    },
  },

  -- Type hierarchy viewer
  {
    'retran/meow.yarn.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('meow.yarn').setup {}
      vim.keymap.set('n', '<leader>yS', '<Cmd>MeowYarn type super<CR>', { desc = 'Yarn: Super Types' })
      vim.keymap.set('n', '<leader>ys', '<Cmd>MeowYarn type sub<CR>', { desc = 'Yarn: Sub Types' })
      vim.keymap.set('n', '<leader>yC', '<Cmd>MeowYarn call callers<CR>', { desc = 'Yarn: Callers' })
      vim.keymap.set('n', '<leader>yc', '<Cmd>MeowYarn call callees<CR>', { desc = 'Yarn: Callees' })
    end,
  },

  -- Xcode development
  {
    'wojciech-kulik/xcodebuild.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('xcodebuild').setup {}

      vim.keymap.set('n', '<leader>X', '<cmd>XcodebuildPicker<cr>', { desc = 'Show Xcodebuild Actions' })
      vim.keymap.set('n', '<leader>xf', '<cmd>XcodebuildProjectManager<cr>', { desc = 'Show Project Manager Actions' })
      vim.keymap.set('n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', { desc = 'Build Project' })
      vim.keymap.set('n', '<leader>xB', '<cmd>XcodebuildBuildForTesting<cr>', { desc = 'Build For Testing' })
      vim.keymap.set('n', '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & Run Project' })
      vim.keymap.set('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run Tests' })
      vim.keymap.set('v', '<leader>xt', '<cmd>XcodebuildTestSelected<cr>', { desc = 'Run Selected Tests' })
      vim.keymap.set('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run Current Test Class' })
      vim.keymap.set('n', '<leader>x.', '<cmd>XcodebuildTestRepeat<cr>', { desc = 'Repeat Last Test Run' })
      vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild Logs' })
      vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code Coverage' })
      vim.keymap.set('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { desc = 'Show Code Coverage Report' })
      vim.keymap.set('n', '<leader>xe', '<cmd>XcodebuildTestExplorerToggle<cr>', { desc = 'Toggle Test Explorer' })
      vim.keymap.set('n', '<leader>xs', '<cmd>XcodebuildFailingSnapshots<cr>', { desc = 'Show Failing Snapshots' })
      vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildPreviewGenerateAndShow<cr>', { desc = 'Generate Preview' })
      vim.keymap.set('n', '<leader>x<cr>', '<cmd>XcodebuildPreviewToggle<cr>', { desc = 'Toggle Preview' })
      vim.keymap.set('n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select Device' })
      vim.keymap.set('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show QuickFix List' })
      vim.keymap.set('n', '<leader>xa', '<cmd>XcodebuildCodeActions<cr>', { desc = 'Show Code Actions' })
    end,
  },

  -- OpenCode AI assistant
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
    },
    ---@type opencode.Opts
    opts = {},
    config = function()
      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        require('opencode').ask('@this: ', { submit = true })
      end, { desc = 'Ask opencode' })
      vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
        require('opencode').select()
      end, { desc = 'Execute opencode action…' })
      vim.keymap.set({ 'n', 'x' }, 'ga', function()
        require('opencode').prompt '@this'
      end, { desc = 'Add to opencode' })
      vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
        require('opencode').toggle()
      end, { desc = 'Toggle opencode' })
      vim.keymap.set('n', '<S-C-u>', function()
        require('opencode').command 'session.half.page.up'
      end, { desc = 'opencode half page up' })
      vim.keymap.set('n', '<S-C-d>', function()
        require('opencode').command 'session.half.page.down'
      end, { desc = 'opencode half page down' })
    end,
  },
}
