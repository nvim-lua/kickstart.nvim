-- LaTeX keybindings and Zathura management

-- Keybinding to compile LaTeX to PDF using xelatex with latexmk and output to the "output" directory
vim.keymap.set(
  'n',
  '<leader>ll',
  ':!mkdir -p output && latexmk -pdf -xelatex -output-directory=output -synctex=1 %<CR>',
  {
    desc = 'Compile LaTeX to PDF using xelatex with SyncTeX in the output directory',
    noremap = true,
    silent = true,
  }
)

-- Keybinding to view the compiled PDF in Zathura from the output directory
vim.keymap.set('n', '<leader>lv', function()
  local pdf_path = vim.fn.expand('%:p:h/output/%:t:r.pdf')

  -- Check if Zathura is already running for this PDF
  local zathura_running = vim.fn.systemlist('pgrep -f "zathura ' .. pdf_path .. '"')

  if #zathura_running == 0 then
    -- Start Zathura if it's not already running for this PDF
    vim.fn.jobstart({ 'zathura', pdf_path }, { detach = true, stdout = 'null', stderr = 'null' })
  else
    print('Zathura is already running for this file.')
  end
end, {
  desc = 'View PDF in Zathura from the output directory',
  noremap = true,
  silent = true,
})

-- Function to close the Zathura instance for the current PDF
local function close_zathura()
  local pdf_path = vim.fn.expand('%:p:h') .. '/output/' .. vim.fn.expand('%:t:r') .. '.pdf'
  -- Terminate Zathura process associated with the PDF
  vim.fn.system({ 'pkill', '-f', 'zathura ' .. pdf_path })
end

-- Keybinding to close Zathura for the current PDF
vim.keymap.set(
  'n',
  '<leader>lc', -- Replace with your preferred key combination
  close_zathura,
  {
    desc = 'Close Zathura instance for the current PDF',
    noremap = true,
    silent = true,
  }
)

-- Prevent multiple Zathura instances and add cooldown period
local last_open_time = 0
local cooldown_period = 5 -- Cooldown period in seconds
local max_instances = 5
local zathura_pids = {}
local auto_close_min = 180

-- Function to schedule Zathura closure after a delay in minutes
local function schedule_close_zathura(minutes)
  local delay_ms = minutes * 60 * 1000 -- Convert minutes to milliseconds
  vim.defer_fn(close_zathura, delay_ms)
end

-- Autocmd to automatically open the PDF in Zathura when a .tex file is opened
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.tex',
  callback = function()
    local current_time = vim.fn.reltimefloat(vim.fn.reltime())
    if current_time - last_open_time < cooldown_period then
      print('Cooldown active, skipping Zathura launch.')
      return
    end

    last_open_time = current_time

    if #zathura_pids >= max_instances then
      print('Maximum number of Zathura instances reached.')
      return
    end

    local pdf_path = vim.fn.expand('%:p:h') .. '/output/' .. vim.fn.expand('%:t:r') .. '.pdf'
    local zathura_running = vim.fn.systemlist('pgrep -f "zathura ' .. pdf_path .. '"')

    if #zathura_running == 0 and vim.fn.filereadable(pdf_path) == 1 then
      local job_id = vim.fn.jobstart({ 'zathura', pdf_path }, { detach = true })
      table.insert(zathura_pids, job_id)
      -- Schedule the closure of Zathura after 180 minutes (3 hours)
      schedule_close_zathura(auto_close_min)
    else
      print('Zathura is already running for this file or PDF not found.')
    end
  end,
})

-- Autocmd to close all Zathura instances related to the current file when exiting Neovim
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    local pdf_path = vim.fn.expand('%:p:h') .. '/output/' .. vim.fn.expand('%:t:r') .. '.pdf'
    vim.fn.system({ 'pkill', '-f', 'zathura ' .. pdf_path })
  end,
})
