globals = {
  'vim',
  'assert',
}

-- Don't report unused self arguments of methods.
self = false

-- Rerun tests only if their modification time changed.
cache = true

ignore = {
  '631', -- max_line_length
  '212/_.*', -- unused argument, for vars with "_" prefix
}
