local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set


--vim.g.loaded_netrw = 1		-- disables netrw
--vim.g.loaded_netrwPlugin = 1
vim.opt.hidden = true		-- keeps open file in register
vim.opt.number = true		-- rownumber
vim.opt.relativenumber = true
vim.opt.list = true		-- shows whitespaces
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.cmd("colorscheme kanagawa")
vim.cmd [[set grepprg=rg\ --vimgrep\ --no-heading\ --hidden\ --smart-case]]
vim.cmd "set nohlsearch noincsearch"
vim.cmd "set cc=80"		-- shows line for file width.
vim.cmd [[autocmd FileType gitcommit setlocal spell cc=72]]
vim.cmd [[autocmd FileType markdown  setlocal spell]]
vim.cmd [[autocmd FileType text      setlocal textwidth=79]]
vim.cmd [[autocmd FileType python  setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8]]


keymap('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<M-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<M-k>", "<Esc>:m .-2<CR>==gi", opts)

-- debugging keymaps
keymap("n","<F5>",":lua require'dap'.continue()<CR>", opts)
keymap("n","<F10>",":lua require'dap'.step_over()<CR>", opts)
keymap("n","<F11>",":lua require'dap'.step_into()<CR>", opts)
keymap("n","<F12>",":lua require'dap'.step_out()<CR>", opts)
keymap("n","<Leader>b",":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n","<Leader>B",":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)

--debug settings
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1

-- filetype overrides
require("filetype").setup({
    overrides = {
        extensions = {
            tf = "terraform",
	    tfvars = "terraform"
        },
    },
})
