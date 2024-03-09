-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
treesitter = { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'python', 'toml', 'sql' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    }

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}

if vim.g.vscode then
  treesitter = {}
end

return {
  treesitter,
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').create_default_mappings()
      require('leap').opts.special_keys.prev_target = ','
      require('leap').opts.special_keys.next_target = ';'
      require('leap').opts.special_keys.prev_group = '<bs>'
      require('leap.user').set_repeat_keys('<cr>', '<bs>')
    end,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker',
        colors = {
          bg0 = '#101010',
          purple = '#c549eb',
          green = '#91db58',
          red = '#f04351',
        },
      }
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'jpalardy/vim-slime',
    config = function()
      vim.cmd.xmap('<leader>s', '<Plug>SlimeRegionSend')
      vim.cmd.vmap('<leader>s', '<Plug>SlimeRegionSend')
      vim.cmd.nmap('<leader>s', '<Plug>SlimeParagraphSend')
      vim.cmd.nmap('<leader>s', '<Plug>SlimeSendCell')
      vim.g.slime_target = 'tmux'
      vim.g.slime_paste_file = '/home/moritz/.slime_paste'
      vim.g.slime_cell_delimiter = '# %%'
      vim.g.slime_default_config = { socket_name = 'default', target_pane = '1' }
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_dont_ask_default = 1
    end,
  },
}
