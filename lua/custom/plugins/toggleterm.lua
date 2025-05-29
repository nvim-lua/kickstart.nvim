-- ToggleTerm configuration
-- https://github.com/akinsho/toggleterm.nvim

return {
  'akinsho/toggleterm.nvim',
  version = "*", -- use the latest stable version
  event = "VeryLazy", -- lazy load on VeryLazy event
  opts = {
    -- Configuration options
    size = function(term)
      if term.direction == "horizontal" then
        return 15  -- Set height for horizontal terminal
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4  -- 40% of screen width
      end
    end,
    open_mapping = [[<C-\>]], -- Ctrl+\ to toggle terminal
    hide_numbers = true, -- hide line numbers
    shade_filetypes = {},
    shade_terminals = true, -- apply shade to terminal
    shading_factor = 2, -- degree of shading (1-3)
    start_in_insert = true, -- start terminal in insert mode
    insert_mappings = true, -- apply mappings in insert mode
    persist_size = true,
    direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
    close_on_exit = true, -- close terminal window when process exits
    shell = vim.o.shell, -- use default shell
    -- Float window settings
    float_opts = {
      border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
      winblend = 0, -- transparency (0-100)
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    }
  },
  config = function(_, opts)
    -- Initialize the plugin with provided options
    require("toggleterm").setup(opts)
    
    -- Terminal keymaps
    function _G.set_terminal_keymaps()
      local keymap_opts = {buffer = 0, noremap = true, silent = true}
      -- Escape terminal mode with Esc key
      vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], keymap_opts)
      -- Terminal navigation
      vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], keymap_opts)
      vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], keymap_opts)
      vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], keymap_opts)
      vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], keymap_opts)
      -- Paste in terminal mode
      vim.keymap.set('t', '<C-v>', [[<C-\><C-n>pi]], keymap_opts)
    end

    -- Auto-command to apply terminal keymaps when terminal opens
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    -- Create additional keymaps for different terminal layouts
    vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', {noremap = true, desc = "Toggle floating terminal"})
    vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', {noremap = true, desc = "Toggle horizontal terminal"})
    vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', {noremap = true, desc = "Toggle vertical terminal"})
    vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=tab<CR>', {noremap = true, desc = "Toggle tab terminal"})
    
    -- Numbered terminals
    vim.keymap.set('n', '<leader>t1', ':1ToggleTerm<CR>', {noremap = true, desc = "Toggle terminal #1"})
    vim.keymap.set('n', '<leader>t2', ':2ToggleTerm<CR>', {noremap = true, desc = "Toggle terminal #2"})
    vim.keymap.set('n', '<leader>t3', ':3ToggleTerm<CR>', {noremap = true, desc = "Toggle terminal #3"})
    
    -- Creating a lazygit terminal
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "curved",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        -- ESC twice to exit lazygit
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
      end,
    })

    -- Function to toggle lazygit terminal
    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end
    
    -- Map lazygit toggle function to a key
    vim.keymap.set('n', '<leader>lg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', {noremap = true, desc = "Toggle LazyGit"})
    
    -- Example for creating a custom Python REPL terminal
    local python = Terminal:new({
      cmd = "python",
      direction = "horizontal",
      close_on_exit = false,
    })
    
    function _PYTHON_TOGGLE()
      python:toggle()
    end
    
    vim.keymap.set('n', '<leader>py', '<cmd>lua _PYTHON_TOGGLE()<CR>', {noremap = true, desc = "Toggle Python REPL"})
  end,
}
