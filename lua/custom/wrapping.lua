local M = {}

local defaults = {
  width = 100,
  patterns = { '*.md', '*.markdown' },
  max_lines = 5000,
  max_bytes = 1024 * 1024,
}

local function apply_wrap_options(local_opts, width)
  local_opts.wrap = true
  local_opts.linebreak = true
  local_opts.breakindent = true
  local_opts.textwidth = width
  local_opts.colorcolumn = ''
  local_opts.formatoptions:append 't'
  local_opts.formatoptions:append 'a'
  local_opts.formatoptions:remove 'l'
end

local function can_reflow(bufnr, opts)
  if not vim.api.nvim_buf_is_valid(bufnr) or not vim.bo[bufnr].modifiable or vim.bo[bufnr].buftype ~= '' then
    return false
  end

  if opts.max_lines and vim.api.nvim_buf_line_count(bufnr) > opts.max_lines then
    return false
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  if name ~= '' and opts.max_bytes then
    local stat = (vim.uv or vim.loop).fs_stat(name)
    if stat and stat.size and stat.size > opts.max_bytes then
      return false
    end
  end

  return true
end

local function reflow_whole_buffer(bufnr, preserve_view, opts)
  if not can_reflow(bufnr, opts) then
    return
  end

  vim.api.nvim_buf_call(bufnr, function()
    local view = preserve_view and vim.fn.winsaveview() or nil
    vim.cmd 'silent keepjumps normal! gggqG'
    if view then
      vim.fn.winrestview(view)
    end
  end)
end

function M.setup(opts)
  opts = vim.tbl_deep_extend('force', defaults, opts or {})

  local group = vim.api.nvim_create_augroup('custom_wrapping_rules', { clear = true })

  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = 'markdown',
    callback = function()
      -- Apply after ftplugins so local overrides don't drop wrap options.
      vim.schedule(function()
        apply_wrap_options(vim.opt_local, opts.width)
      end)
    end,
  })

  vim.api.nvim_create_autocmd('BufReadPost', {
    group = group,
    pattern = opts.patterns,
    callback = function(args)
      -- Reflow existing prose on open so the hard wrap rule is applied immediately.
      if vim.b[args.buf].did_initial_wrap then
        return
      end
      vim.b[args.buf].did_initial_wrap = true
      vim.schedule(function()
        reflow_whole_buffer(args.buf, false, opts)
      end)
    end,
  })

  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = opts.patterns,
    callback = function(args)
      if not vim.bo[args.buf].modified then
        return
      end
      reflow_whole_buffer(args.buf, true, opts)
    end,
  })
end

return M
