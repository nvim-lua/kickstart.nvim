

return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    cmd = { "ToggleTerm", "TermExec" },
    config = function()
      -- Lazygit
      local Terminal  = require('toggleterm.terminal').Terminal
      local defaultTerm = Terminal:new({ cmd = "zsh", hidden = true, orientation = "float" })
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
      local pythonREPL = Terminal:new({ cmd = "python3", hidden = true })
      local haskellREPL = Terminal:new({ cmd = "ghci", hidden = true })

      function _defaultterm_toggle()
        defaultTerm:toggle()
      end
      function _lazygit_toggle()
        lazygit:toggle()
      end

      function _pythonREPL_toggle()
        pythonREPL:toggle()
      end

      function _haskellREPL_toggle()
        haskellREPL:toggle()
      end

      vim.keymap.set('n', '<space>tt', "<cmd>lua _defaultterm_toggle()<CR>", { desc = 'Toggle Lazygit', noremap = true, silent = true })
      vim.keymap.set('n', '<F7>', "<cmd>lua _defaultterm_toggle()<CR>", { desc = 'Toggle Lazygit', noremap = true, silent = true })
      vim.keymap.set('n', '<space>tl', "<cmd>lua _lazygit_toggle()<CR>", { desc = 'Toggle Lazygit', noremap = true, silent = true })
      vim.keymap.set('n', '<space>tp', "<cmd>lua _pythonREPL_toggle()<CR>", { desc = 'Toggle Python3 REPL', noremap = true, silent = true })
      vim.keymap.set('n', '<space>th', "<cmd>lua _haskellREPL_toggle()<CR>", { desc = 'Toggle GHCI', noremap = true, silent = true })
    end,
    opts = {
      size = 10,
      on_create = function()
        vim.opt.foldcolumn = "0"
        vim.opt.signcolumn = "no"
      end,
      open_mapping = [[<F7>]],
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
  },
}
