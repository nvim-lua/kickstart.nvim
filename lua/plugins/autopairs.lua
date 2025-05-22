return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- Load when entering insert mode
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      disable_filetype = { "TelescopePrompt", "vim" },
      check_ts = true, -- Use Treesitter to check for pairs
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string nodes
        javascript = { "template_string" },
        java = false, -- disable treesitter check for Java
      },
      fast_wrap = {
        map = "<M-e>", -- Alt+e to trigger fast wrap
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        before_key = "h",
        after_key = "l",
        cursor_pos_before = true,
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment"
      },
      enable_check_bracket_line = true, -- Don't add a pair if the closing bracket is already on the same line
      ignored_next_char = "[%w%.]", -- Will ignore alphanumeric and `.` after the pair
    })

    -- Optional: Integration with nvim-cmp for auto completion pairing
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if cmp_status_ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
