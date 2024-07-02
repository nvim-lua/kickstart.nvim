require("custom.core.keymaps")
require("custom.core.options")

return {
  -- 'christoomey/vim-tmux-navigator',
  'nvim-lua/popup.nvim', -- used by other plugins
  'szw/vim-maximizer',  -- maximizes and restores current window
  'tpope/vim-surround',  -- add, delete, change surroundings (it's awesome)
  'vim-scripts/ReplaceWithRegister',  -- replace with register contents using motion (gr + motion)
  'kyazdani42/nvim-web-devicons', -- vs-code like icons
  'fedepujol/move.nvim', -- move line/block up/down
  -- 'hrsh7th/cmp-buffer',  -- source for text in buffer,
  -- 'hrsh7th/cmp-path',  -- source for file system paths
  'rafamadriz/friendly-snippets', -- useful snippets
  -- { "glepnir/lspsaga.nvim", branch = "main" }, -- enhanced lsp uis
  -- 'jose-elias-alvarez/typescript.nvim', -- additional functionality for typescript server (e.g. rename file & update imports) 
  -- 'onsails/lspkind.nvim', -- vs-code like icons for autocompletion
  -- 'jose-elias-alvarez/null-ls.nvim',  -- configure formatters & linters
  -- 'jayp0521/mason-null-ls.nvim',  -- bridges gap b/w mason & null-ls
  { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }, -- autoclose tags
  'ThePrimeagen/harpoon', -- the name is... ThePrimeagen
  'MattesGroeger/vim-bookmarks', -- vim-bookmarks
  'tom-anders/telescope-vim-bookmarks.nvim', -- telescope-vim-bookmarks
  'tpope/vim-unimpaired', -- vim-unimpared
  -- 'nvim-telescope/telescope-media-files.nvim', -- doesnt work for windows
  'nvim-telescope/telescope-file-browser.nvim',
  'RRethy/vim-illuminate',
  'mbbill/undotree',
  -- 'styled-components/vim-styled-components'
}

