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


  -- Add a smart format-on-save command that only uses null-ls
  -- Fix for zig.vim ftplugin error - handles both JSON and struct output
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'zig',
    group = vim.api.nvim_create_augroup('user-zig-fix', { clear = true }),
    callback = function()
      if vim.fn.executable('zig') ~= 1 or vim.g.zig_std_dir then return end
      
      -- First try with --json flag
      local handle = io.popen('zig env --json 2>/dev/null')
      if handle then
        local result = handle:read('*a')
        handle:close()
        
        -- Try to parse as JSON first
        local success, env = pcall(vim.fn.json_decode, result)
        if success and type(env) == 'table' and env.std_dir then
          vim.g.zig_std_dir = env.std_dir
          vim.opt_local.path:prepend(env.std_dir)
          return
        end
      end
      
      -- If JSON parsing failed, try to parse the struct output
      handle = io.popen('zig env 2>/dev/null')
      if handle then
        local result = handle:read('*a')
        handle:close()
        
        -- Extract std_dir from struct output
        local std_dir = result:match('%.std_dir%s*=%s*"([^"]+)"')
        if std_dir then
          vim.g.zig_std_dir = std_dir
          vim.opt_local.path:prepend(std_dir)
        end
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
