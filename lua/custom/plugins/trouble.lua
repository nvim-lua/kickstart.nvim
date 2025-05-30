-- Trouble - A pretty diagnostics, references, telescope results, quickfix and location list
-- https://github.com/folke/trouble.nvim

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TroubleToggle", "Trouble" },
  opts = {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 12, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
      close = "q", -- close the list
      cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r", -- manually refresh
      jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
      open_split = { "<c-x>" }, -- open buffer in new split
      open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
      open_tab = { "<c-t>" }, -- open buffer in new tab
      jump_close = {"o"}, -- jump to the diagnostic and close the list
      toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
      switch_severity = "s", -- switch "diagnostics" severity filter
      toggle_preview = "P", -- toggle auto_preview
      hover = "K", -- opens a small popup with the full multiline message
      preview = "p", -- preview the diagnostic location
      open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
      close_folds = {"zM", "zm"}, -- close all folds
      open_folds = {"zR", "zr"}, -- open all folds
      toggle_fold = {"zA", "za"}, -- toggle fold of current file
      previous = "k", -- previous item
      next = "j", -- next item
      help = "?" -- help menu
    },
    multiline = true, -- render multi-line messages
    indent_lines = true, -- add an indent guide below the fold icons
    win_config = { border = "rounded" }, -- window configuration for floating windows
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    signs = {
      -- icons / text used for a diagnostic
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "",
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
  },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP References (Trouble)" },
    { "gD", "<cmd>TroubleToggle lsp_definitions<cr>", desc = "LSP Definitions (Trouble)" },
    { "<leader>xT", "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)", cond = function() return require("lazy.core.config").spec.plugins["todo-comments"] ~= nil end },
  },
  config = function(_, opts)
    require("trouble").setup(opts)
    
    -- Add which-key group
    local ok, which_key = pcall(require, "which-key")
    if ok then
      which_key.register({
        ["<leader>x"] = { 
          name = "Trouble/Diagnostics", 
          x = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
          X = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
          L = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
          Q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix List" },
          T = { "<cmd>TodoTrouble<cr>", "TODOs" },
        },
      })
    end
  end,
}
