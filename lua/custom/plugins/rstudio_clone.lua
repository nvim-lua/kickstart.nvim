-- Enable filetype detection
vim.cmd('filetype plugin on')

-- Function to setup RStudio-like layout
local function setup_rstudio_layout()
  -- Close any existing buffers to start fresh
  vim.cmd('silent! %bdelete!')
  
  -- Set up the main layout with 4 quadrants
  vim.cmd('vsplit')                    -- Vertical split (left/right)
  vim.cmd('split')                     -- Horizontal split in left pane (top-left/bottom-left)
  vim.cmd('wincmd l')                  -- Move to right pane
  vim.cmd('split')                     -- Horizontal split in right pane (top-right/bottom-right)
  
  -- Navigate to each quadrant and set them up
  -- Top Left: Code/Text Editor (current buffer)
  vim.cmd('wincmd t')                  -- Move to top-left
  
  -- Bottom Left: Terminal/Console
  vim.cmd('wincmd j')                  -- Move to bottom-left
  vim.cmd('resize 15')                 -- Set height for console
  vim.cmd('terminal')                  -- Open terminal
  vim.cmd('startinsert')               -- Enter insert mode in terminal
  
  -- Top Right: Various panels (Git, CSV, etc.)
  vim.cmd('wincmd l')                  -- Move to top-right
  vim.cmd('vsplit')                    -- Split top-right vertically for multiple tabs
  vim.cmd('wincmd h')                  -- Move to left side of top-right
  
  -- Set up tabbed interface for top-right
  vim.cmd('tabnew')                    -- Create new tab for Git
  vim.cmd('Neotree git_status')        -- Requires neo-tree.nvim
  
  vim.cmd('tabnew')                    -- Create new tab for CSV/data
  vim.cmd('DBUI')                      -- Requires vim-dadbod-ui for database/CSV viewing
  
  vim.cmd('tabfirst')                  -- Go back to first tab
  
  -- Bottom Right: Plots, Directory, Help
  vim.cmd('wincmd j')                  -- Move to bottom-right
  vim.cmd('split')                     -- Split bottom-right
  vim.cmd('wincmd j')                  -- Move to lower part of bottom-right
  
  -- Set up tabbed interface for bottom-right
  vim.cmd('tabnew')                    -- Tab for file explorer
  vim.cmd('Neotree filesystem')        -- File tree
  
  vim.cmd('tabnew')                    -- Tab for plots (image preview)
  vim.cmd('terminal')                  -- Terminal for displaying plots
  vim.cmd('startinsert')
  
  vim.cmd('tabnew')                    -- Tab for help
  vim.cmd('help')                      -- Open help
  
  vim.cmd('tabfirst')                  -- Go back to first tab
  
  -- Return to main editor (top-left)
  vim.cmd('wincmd t')                  -- Back to top-left
  
  -- Set window sizes
  vim.cmd('vertical resize 60')        -- Set width for left panes
end

-- Function to check if we should setup RStudio layout
local function setup_filetype_layout()
  local ft = vim.bo.filetype
  if ft == 'r' or ft == 'rmd' or ft == 'quarto' then
    -- Only setup if we're in a GUI or fullscreen and not already setup
    if vim.fn.has('gui_running') == 1 then
      setup_rstudio_layout()
    end
  end
end

-- Auto commands for R and Rmd files
vim.api.nvim_create_autocmd({'BufWinEnter', 'FileType'}, {
  pattern = {'*.r', '*.R', '*.rmd', '*.Rmd', '*.RMD'},
  callback = function()
    vim.schedule(function()
      setup_filetype_layout()
    end)
  end
})

-- Plugin configuration
return require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  
  -- File tree and git status
  use {
    'nvim-neo-tree/neo-tree.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup({
        filesystem = {
          hijack_netrw_behavior = "open_default"
        }
      })
    end
  }
  
  -- Database/CSV viewer
  use {
    'kristijanhusak/vim-dadbod-ui',
    requires = {'tpope/vim-dadbod'}
  }
  
  -- Terminal management
  use {'akinsho/toggleterm.nvim', tag = '*', config = function()
    require('toggleterm').setup()
  end}
  
  -- R language support
  use 'jalvesaq/Nvim-R'
  
  -- Markdown support for Rmd files
  use 'preservim/vim-markdown'
  
  -- Image preview for plots
  use 'edluffy/hologram.nvim'
  
  -- Better syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'
  
end)
