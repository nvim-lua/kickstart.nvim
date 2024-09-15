-- markdown.lua

-- Update PATH to include TeX binaries
vim.env.PATH = vim.env.PATH .. ':/Library/TeX/texbin'

-- Utility function to create directories if they do not exist
local function ensure_directory_exists(path)
  if not vim.fn.isdirectory(path) then
    vim.fn.mkdir(path, 'p')
  end
end

-- Generate the PDF target directory and file paths
local function generate_pdf_paths(filename)
  local base_dir = vim.fn.fnamemodify(filename, ':h')
  local target_dir = base_dir:gsub('/src$', '/pdf')
  local output_file = vim.fn.fnamemodify(filename, ':t:r') .. '.pdf'
  local output_path = target_dir .. '/' .. output_file

  -- Ensure the target directory exists
  ensure_directory_exists(target_dir)

  return target_dir, output_file, output_path
end

-- Build PDF using the buildnote script
local function build_pdf(filename, output_path)
  local command = string.format('buildnote %s %s', vim.fn.shellescape(filename), vim.fn.shellescape(output_path))
  return vim.fn.systemlist(command)
end

-- Check if Zathura is running and open it if not
local function open_pdf_in_zathura(pdf_path)
  local zathura_running = vim.fn.systemlist('pgrep -f "zathura ' .. vim.fn.shellescape(pdf_path) .. '"')

  if #zathura_running == 0 then
    vim.fn.jobstart({ 'zathura', pdf_path }, { detach = true, stdout = 'null', stderr = 'null' })
    print('Opening PDF in Zathura: ' .. pdf_path)
  else
    print('Zathura is already running for this file.')
  end
end

-- Keybinding to build the PDF and view it in Zathura
vim.keymap.set('n', '<leader>lv', function()
  local filename = vim.fn.expand('%:p')
  local _, _, output_path = generate_pdf_paths(filename)

  -- Build the PDF
  local result = build_pdf(filename, output_path)

  if #result == 0 then
    print('Error: Could not generate PDF.')
    return
  end

  -- Open the PDF in Zathura
  open_pdf_in_zathura(output_path)
end, {
  desc = 'View output PDF in Zathura',
  noremap = true,
  silent = true,
})

-- Autocmd to close all Zathura instances related to the current file when exiting Neovim
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    local _, _, output_path = generate_pdf_paths(vim.fn.expand('%:p'))
    vim.fn.system({ 'pkill', '-f', 'zathura ' .. output_path })
  end,
})

-- Auto-run `buildnote` for files matching `*note-*.md` on save
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*note-*.md',
  callback = function()
    local filename = vim.fn.expand('%:p')
    local _, _, output_path = generate_pdf_paths(filename)

    if vim.fn.filereadable(filename) == 1 then
      -- Execute the buildnote script to generate the PDF
      local command = string.format('buildnote %s %s', vim.fn.shellescape(filename), vim.fn.shellescape(output_path))
      vim.cmd('silent !' .. command)
    else
      print('Error: File ' .. filename .. ' does not exist.')
    end
  end,
})
