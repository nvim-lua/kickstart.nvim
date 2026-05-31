-- Shader file associations
vim.filetype.add {
  extension = {
    vert = 'glsl',
    frag = 'glsl',
    geom = 'glsl',
    comp = 'glsl',
    tesc = 'glsl',
    tese = 'glsl',
  },
}

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Load project-local config
local uv = vim.uv or vim.loop

local function load_project_config()
  local config_file = vim.fn.getcwd() .. '/.nvim.lua'
  if vim.fn.filereadable(config_file) ~= 1 then
    return
  end

  local stat = uv.fs_lstat(config_file)
  if not (stat and stat.type == 'file') then
    return
  end

  local ok, err = pcall(dofile, config_file)
  if not ok then
    vim.notify('Error loading project config: ' .. err, vim.log.levels.WARN)
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Load project-local .nvim.lua',
  group = vim.api.nvim_create_augroup('project-local-config', { clear = true }),
  callback = load_project_config,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      vim.schedule(function()
        vim.cmd 'normal! zz'
      end)
    end
  end,
})

-- Open help in vertical split
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  command = 'wincmd L',
})

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd('VimResized', {
  command = 'wincmd =',
})

-- No auto continue comments on new line
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('no_auto_comment', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- Show cursorline only in active window (enable)
local cursorline_group = vim.api.nvim_create_augroup('active_cursorline', { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- Show cursorline only in active window (disable)
vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
