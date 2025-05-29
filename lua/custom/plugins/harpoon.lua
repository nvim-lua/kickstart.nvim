-- Harpoon configuration
-- https://github.com/ThePrimeagen/harpoon
-- Fast file navigation to frequently used files

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- Using harpoon2 for the latest version
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")
    
    -- Set up harpoon with enhanced settings
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      }
    })
  end,
  keys = {
    { 
      "<leader>ha", 
      function() 
        require("harpoon"):list():add() 
      end,
      desc = "Harpoon add file" 
    },
    { 
      "<leader>hm", 
      function() 
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list()) 
      end,
      desc = "Harpoon menu" 
    },
    { 
      "<leader>h1", 
      function() 
        require("harpoon"):list():select(1) 
      end,
      desc = "Harpoon file 1" 
    },
    { 
      "<leader>h2", 
      function() 
        require("harpoon"):list():select(2) 
      end,
      desc = "Harpoon file 2" 
    },
    { 
      "<leader>h3", 
      function() 
        require("harpoon"):list():select(3) 
      end,
      desc = "Harpoon file 3" 
    },
    { 
      "<leader>h4", 
      function() 
        require("harpoon"):list():select(4) 
      end,
      desc = "Harpoon file 4" 
    },
    { 
      "<leader>h5", 
      function() 
        require("harpoon"):list():select(5) 
      end,
      desc = "Harpoon file 5" 
    },
    { 
      "<leader>hn", 
      function() 
        require("harpoon"):list():next() 
      end,
      desc = "Harpoon next file" 
    },
    { 
      "<leader>hp", 
      function() 
        require("harpoon"):list():prev() 
      end,
      desc = "Harpoon previous file" 
    },
  }
}
