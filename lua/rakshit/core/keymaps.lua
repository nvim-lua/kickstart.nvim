-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
-- See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Delete entire word with Alt+Backspace
vim.keymap.set("i", "<A-BS>", "<C-W>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windowsC
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit window [V]ertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit window [H]orizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make [S]plit [E]qual size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Current [S]plit [X]Close" })

-- Tab management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Gopher plugin keymaps
vim.keymap.set("n", "<leader>if", "<cmd> GoIfErr <CR>", { desc = "Add if err != nil snippet" })

-- Borrowed from my VS Code settings for better Vim navigations
vim.keymap.set({ "n", "v" }, "<leader>l", "$", { desc = "Move to end of the line with leader + l" })
vim.keymap.set({ "n", "v" }, "<leader>h", "_", { desc = "Move to first character of the line with leader + h" })

-- Gitsigns to toggle hunk preview and git line blame
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview changes made on the current line" })
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "View current line blame" })

-- Start resize mode
vim.keymap.set(
  "n",
  "<leader>z",
  ":lua EnterResizeMode()<CR>",
  { desc = "Resi[z]e Mode", noremap = true, silent = true }
)

-- Define the resize mode function
function EnterResizeMode()
  print("Resize mode: press 'h' or 'l' for vertical resize and 'j' or 'k' for horizontal resize, 'q' to quit")
  vim.keymap.set("n", "h", ":vertical resize +5<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "l", ":vertical resize -5<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "j", ":horizontal resize +5<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "k", ":horizontal resize -5<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "q", ":lua ExitResizeMode()<CR>", { noremap = true, silent = true })
end

-- Define the exit resize mode function
function ExitResizeMode()
  vim.api.nvim_del_keymap("n", "h")
  vim.api.nvim_del_keymap("n", "l")
  vim.api.nvim_del_keymap("n", "j")
  vim.api.nvim_del_keymap("n", "k")
  vim.api.nvim_del_keymap("n", "q")
  print("Exited Resize Mode")
end

-- Noice
vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })
vim.keymap.set("n", "<leader>ndb", "<cmd>NoiceDisable<CR>", { desc = "Dismiss Noice Message" })
vim.keymap.set("n", "<leader>ne", "<cmd>NoiceEnable<CR>", { desc = "Dismiss Noice Message" })
vim.keymap.set("n", "<leader>nl", "<cmd>NoiceLast<CR>", { desc = "Dismiss Noice Message" })
vim.keymap.set("n", "<leader>nt", "<cmd>NoiceTelescope<CR>", { desc = "Dismiss Noice Message" })
--[[
--
- `:Noice` or `:Noice history` shows the message history
- `:Noice last` shows the last message in a popup
- `:Noice dismiss` dismiss all visible messages
- `:Noice errors` shows the error messages in a split. Last errors on top
- `:Noice disable` disables **Noice**
- `:Noice enable` enables **Noice**
- `:Noice stats` shows debugging stats
- `:Noice telescope` opens message history in Telescope

Alternatively, all commands also exist as a full name like `:NoiceLast`,
`:NoiceDisable`.

You can also use `Lua` equivalents.

>lua
    vim.keymap.set("n", "<leader>nl", function()
      require("noice").cmd("last")
    end)
    
    vim.keymap.set("n", "<leader>nh", function()
      require("noice").cmd("history")
    end)
--]]

-- Execute highlighted lua commands
vim.keymap.set("v", "<leader>ex", ":lua<CR>", { desc = "[EX]ecute highlighted lua code" })
