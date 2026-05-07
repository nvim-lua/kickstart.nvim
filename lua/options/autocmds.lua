---@diagnostic disable: undefined-global
local M = {}

function M.setup()
  -- Highlight when yanking (copying) text
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })


  -- Fix for zig.vim ftplugin error - cache zig env result
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'zig',
    group = vim.api.nvim_create_augroup('user-zig-fix', { clear = true }),
    callback = function()
      if vim.fn.executable('zig') ~= 1 or vim.g.zig_std_dir then return end

      -- Single popen call - try JSON first (newer zig), fallback to struct parsing
      local handle = io.popen('zig env 2>/dev/null')
      if not handle then return end

      local result = handle:read('*a')
      handle:close()

      -- Try JSON parse first
      local success, env = pcall(vim.fn.json_decode, result)
      if success and type(env) == 'table' and env.std_dir then
        vim.g.zig_std_dir = env.std_dir
      else
        -- Fallback: extract from struct output
        vim.g.zig_std_dir = result:match('%.std_dir%s*=%s*"([^"]+)"')
      end

      if vim.g.zig_std_dir then
        vim.opt_local.path:prepend(vim.g.zig_std_dir)
      end
    end,
  })

  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function(args)
      local bufnr = args.buf
      -- Check if null-ls is the formatter for this buffer
      local client = vim.lsp.get_clients({ name = 'null-ls', bufnr = bufnr })[1]
      if not client then
        return
      end

      -- Format the buffer
      vim.lsp.buf.format({ bufnr = bufnr, filter = function(c) return c.name == 'null-ls' end, async = false })
    end,
  })
end

return M
