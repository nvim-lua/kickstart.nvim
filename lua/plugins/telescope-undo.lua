return {
  'debugloop/telescope-undo.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  -- lazy = true,
  keys = {
    { -- lazy style key map
      '<leader>su',
      function()
        require('telescope').extensions.undo.undo()
      end,
      desc = '[S]earch [U]ndo history',
    },
  },
  opts = {
    extensions = {
      undo = {
        -- side_by_side = true,
        -- layout_strategy = 'flex',
        mappings = {
          i = {
            ['<CR>'] = function(buff)
              return require('telescope-undo.actions').yank_additions(buff)
            end,
            ['<S-CR>'] = false,
            ['<C-CR>'] = false,
            -- alternative defaults, for users whose terminals do questionable things with modified <cr>
            ['<C-m>'] = function(buff)
              return require('telescope-undo.actions').yank_additions(buff)
            end,
            ['<C-y>'] = function(buff)
              return require('telescope-undo.actions').yank_additions(buff)
            end,
            ['<C-S-y>'] = function(buff)
              return require('telescope-undo.actions').yank_deletions(buff)
            end,
            ['<C-r>'] = function(buff)
              return require('telescope-undo.actions').restore(buff)
            end,
          },
          n = {
            ['y'] = function(buff)
              return require('telescope-undo.actions').yank_additions(buff)
            end,
            ['Y'] = function(buff)
              return require('telescope-undo.actions').yank_deletions(buff)
            end,
            ['u'] = function(buff)
              return require('telescope-undo.actions').restore(buff)
            end,
          },
        },
      },
    },
  },
  config = function(_, opts)
    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
    -- configs for us. We won't use data, as everything is in it's own namespace (telescope
    -- defaults, as well as each extension).
    require('telescope').setup(opts)
    require('telescope').load_extension 'undo'
  end,
}
