return {
  "lalitmee/browse.nvim",
  depends = { "nvim-telescope/telescope.nvim" },
  lazy = false,
  config = function()
    local bookmarks = {
      ["SE GitHub"] = {
        ["Landing Page"] = "https://github.schneider-electric.com/",
        ["Hpc-Firmware"] = "https://github.schneider-electric.com/MSol-NGM-HPC/hpc-firmware",
        ["SEAPyPI"] = "https://github.schneider-electric.com/SEAPyPI",
        ["Code Search"] = "https://github.schneider-electric.com/search?q=%s&type=code",
        ["Repo Search"] = "https://github.schneider-electric.com/search?q=%s&type=repositories",
        ["Issues Search"] = "https://github.schneider-electric.com/search?q=%s&type=issues",
        ["Pulls Search"] = "https://github.schneider-electric.com/search?q=%s&type=pullrequests",
      },
      ["GitHub"] = {
        ["GitHub.com"] = "https://github.com/",
        ["Code Search"] = "https://github.com/search?q=%s&type=code",
        ["Repo Search"] = "https://github.com/search?q=%s&type=repositories",
        ["Issues Search"] = "https://github.com/search?q=%s&type=issues",
        ["Pulls Search"] = "https://github.com/search?q=%s&type=pullrequests",
      },
      ["SE"] = {
        ["Support"] = "https://schneider.service-now.com/supportatschneider?id=se_index",
        ["Spice"] = "https://spice.se.com/",
        ["Jira Board"] = "https://jira.se.com/secure/RapidBoard.jspa?rapidView=7703&quickFilter=61920#",
        ["Jira Landing"] = "https://jira.se.com/",
        ["TimeSheet"] = "https://se-ppm.sciforma.net/sciforma/?ACSREQUESTID=_f2b21659-6f25-470d-bab7-dbf9e5dbac64#2766",
      },
      ["AvistoConnector"] = "https://vpn.elsys-eastern.com:1443/remote/login?lang=en",
      ["Ziteboard"] = "https://app.ziteboard.com",
    }
    local browse = require "browse"

    function command(name, rhs, opts)
      opts = opts or {}
      vim.api.nvim_create_user_command(name, rhs, opts)
    end

    command("InputSearch", function() browse.input_search() end, {})

    -- this will open telescope using dropdown theme with all the available options
    -- in which `browse.nvim` can be used
    command("Browse", function() browse.browse { bookmarks = bookmarks } end)

    command("Bookmarks", function() browse.open_bookmarks { bookmarks = bookmarks } end)

    command("DevdocsSearch", function() browse.devdocs.search() end)

    command("DevdocsFiletypeSearch", function() browse.devdocs.search_with_filetype() end)

    command("MdnSearch", function() browse.mdn.search() end)
    browse.setup {
      -- search provider you want to use
      provider = "duckduckgo", -- duckduckgo, bing

      -- either pass it here or just pass the table to the functions
      -- see below for more
      bookmarks = {},
      icons = {
        bookmark_alias = "->", -- if you have nerd fonts, you can set this to ""
        bookmarks_prompt = "", -- if you have nerd fonts, you can set this to "󰂺 "
        grouped_bookmarks = "->", -- if you have nerd fonts, you can set this to 
      },
    }
  end,
}
