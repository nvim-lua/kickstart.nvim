return {
  bigfile = { enabled = true },
  input = { enabled = true },
  notifier = { 
    enabled = true,
    timeout = 3000, -- notifications auto-close after 3s
    render = {
      max_width = 100,
      min_width = 20,
      padding = 1,
      format = {
        default = "   {message}",
        notify = "   {title}\n   {message}",
        error = "   {title}\n   {message}",
        warn = "   {title}\n   {message}",
        info = "   {title}\n   {message}",
      },
    },
  },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  scratch = {
    enabled = true,
    float = {
      border = "rounded",
      width = 0.8,
      height = 0.8,
    },
  },
  bufdelete = {
    enabled = true,
    next = "cycle",
  },
}
