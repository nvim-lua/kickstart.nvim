-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
  },
  opts = {
    filesystem = {
      window = {
        position = 'float',
        mappings = {
          ['\\'] = 'close_window',
          -- Add a new key mapping to open a terminal in a floating window
          ['t'] = {
            function(state)
              -- Save the original working directory
              local original_dir = vim.fn.getcwd()

              -- Retrieve the current path from the NeoTree state
              local current_dir = state.tree:get_node().path
              if vim.fn.isdirectory(current_dir) == 0 then
                current_dir = vim.fn.fnamemodify(current_dir, ':h')
              end
              vim.cmd('cd ' .. current_dir)

              -- Configure floating window options
              local width = math.floor(vim.o.columns * 0.8)
              local height = math.floor(vim.o.lines * 0.8)
              local opts = {
                relative = 'editor',
                width = width,
                height = height,
                col = math.floor((vim.o.columns - width) / 2),
                row = math.floor((vim.o.lines - height) / 2),
                style = 'minimal',
                border = 'rounded', -- Other options: 'single', 'double', 'solid', 'shadow'
              }

              -- Create a new buffer for the terminal
              local buf = vim.api.nvim_create_buf(false, true)
              local win = vim.api.nvim_open_win(buf, true, opts)

              -- Start terminal in the floating window
              vim.fn.termopen(vim.o.shell)
              vim.cmd 'startinsert'

              -- Set a keymap to close the floating terminal window
              vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', '<C-\\><C-n>:q!<CR>', { noremap = true, silent = true })

              -- Restore the original working directory
              vim.cmd('cd ' .. original_dir)
            end,
            desc = 'Open terminal in a floating window at current directory', -- Description for the keymap
          },
        },
      },
    },
  },
}
