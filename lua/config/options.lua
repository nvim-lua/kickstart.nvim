local opt = vim.opt
local g = vim.g
local options = {
  -- change cursor in insert mode
  guicursor = "",

  -- Make line numbers default
  relativenumber = true,

  -- Enable mouse mode
  mouse = 'a',

  -- Enable break indent
  breakindent = true,

  -- Indent Configuration
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  expandtab = true,

  smartindent = true,

  -- Disable line wrap
  wrap = false,

  -- Save undo history_list
  swapfile = false,
  backup = false,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,

  -- Searching Configuration
  hlsearch = false,
  incsearch = true,

  -- Case-insensitive searching UNLESS \C or capital in search
  ignorecase = true,
  smartcase = true,

  -- Decrease update time
  updatetime = 50,
  timeoutlen = 300,

  -- Set completeopt to have a better completion experience
  completeopt = 'menuone,noselect',

  -- NOTE: You should make sure your terminal supports this
  termguicolors = true,
  scrolloff = 10,
  --     isfname:append("@-@"),
  colorcolumn = "80",
  -- part of the neovim imprioving command below
  pyxversion = 3
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

local win_local = {
  signcolumn = 'yes',
  number = true,
}

for k, v in pairs(win_local) do
  vim.wo[k] = v
end

-- disable builtins plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  --  "netrw",
  "netrwFileHandlers",
  "loaded_remote_plugins",
  "loaded_tutor_mode_plugin",
  "netrwPlugin",
  "netrwSettings",
  "rrhelper",
  "spellfile_plugin",
  "tar",
  "tarPlugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "matchparen", -- matchparen.nvim disables the default
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

--
-- IMPROVE NEOVIM STARTUP
-- https://github.com/editorconfig/editorconfig-vim/issues/50
local global_let_opts = {
  loaded_python_provier = 0,
  loaded_python3_provider = 0,
  python_host_skip_check = 1,
  -- python_host_prog = '/bin/python2',
  python3_host_skip_check = 1,
  python3_host_prog = '/usr/local/bin/python3',
  EditorConfig_core_mode = 'external_command',
  -- https://vi.stackexchange.com/a/5318/7339
  matchparen_timeout = 20,
  matchparen_insert_timeout = 20,
}

for k, v in pairs(global_let_opts) do
  vim.g[k] = v
end

opt.formatoptions = "l"
opt.formatoptions = opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore

opt.guicursor = {
  "n-v:block",
  "i-c-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
  "i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}
