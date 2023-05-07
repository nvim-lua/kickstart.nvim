-- my basic skeleton implementation
vim.api.nvim_create_autocmd({'BufNewFile'}, {
  callback = function (args)
    local lines = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
    local skeleton_files = vim.api.nvim_get_runtime_file('templates/skeleton.*', true)
    local skeleton_path = 'templates/skeleton.'

    -- fist bail out if we have any lines in this file
    if #lines ~= 1 or lines[1] ~= "" then return end

    -- now bail if we don't have any skeleton files
    if #skeleton_files == 0 then return end
    table.sort(skeleton_files, function (a, b) return #a>#b end)

    for i,v in pairs(skeleton_files) do
      local start, finish = string.find(v, skeleton_path)
      local match = string.sub(v, finish+1, -1)
      if string.match(args.file, match .. '$') then
        -- we have a matching skel file so read it in
        vim.cmd('%!cat ' .. v)
        vim.notify("Skeleton file used to create file: " .. v, vim.log.levels.INFO, { title = "Sessions" })
        break
      end
    end
  end,
  desc = "Simple skeleton file function to match buffer name to a template and add the content to the new file"
})
