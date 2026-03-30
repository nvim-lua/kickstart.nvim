return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = function(_, opts)
      opts.enable_git_status = true

      opts.default_component_configs = vim.tbl_deep_extend('force', opts.default_component_configs or {}, {
        git_status = {
          symbols = {
            added = 'A',
            modified = 'M',
            deleted = 'D',
            renamed = 'R',
            untracked = 'U',
            ignored = 'I',
            unstaged = '*',
            staged = '+',
            conflict = '!',
          },
        },
      })

      opts.filesystem = vim.tbl_deep_extend('force', opts.filesystem or {}, {
        use_libuv_file_watcher = true,
        follow_current_file = { enabled = true },
        window = {
          mappings = {
            ['R'] = 'refresh',
          },
        },
      })
    end,
    config = function(_, opts)
      require('neo-tree').setup(opts)

      local group = vim.api.nvim_create_augroup('NeoTreeAutoRefresh', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'FocusGained' }, {
        group = group,
        callback = function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == 'neo-tree' then
              vim.cmd 'silent! Neotree refresh'
              return
            end
          end
        end,
      })
    end,
  },
}
