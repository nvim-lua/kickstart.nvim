local createImporter = function(path)
  return function(module)
    require(path .. "." .. module)
  end
end

local createNmap = function(opts)
  return function(keys, func, _desc)
    if opts.desc then
      _desc = opts.desc .. _desc
    end

    local newOpts = { desc = _desc }

    for k, v in pairs(newOpts) do opts[k] = v end

    vim.keymap.set('n', keys, func, newOpts)
  end
end

return {
  createImporter = createImporter,
  createNmap = createNmap,
}
