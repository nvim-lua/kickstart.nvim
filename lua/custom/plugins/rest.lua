return {
  "rest-nvim/rest.nvim",
  -- enabled = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = "http",
  config = function()
    local rest_nvim = require "rest-nvim"

    rest_nvim.setup {
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = true,
      encode_url = false,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = ".env",
      custom_dynamic_variables = {},
      yank_dry_run = true,
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "http",
      callback = function()
        local buff = tonumber(vim.fn.expand "<abuf>", 10)
        vim.keymap.set(
          "n",
          "<leader>rc",
          rest_nvim.run,
          { noremap = true, buffer = buff, desc = "Run near http request" }
        )
        vim.keymap.set(
          "n",
          "<leader>rl",
          rest_nvim.last,
          { noremap = true, buffer = buff, desc = "Run last http resquest" }
        )
        vim.keymap.set("n", "<leader>rp", function()
          rest_nvim.run(true)
        end, { noremap = true, buffer = buff, desc = "Preview http curl" })
      end,
    })
  end,
}
-- return {
-- 	'BlackLight/nvim-http'
-- }
-- return {
-- 	"rest-nvim/rest.nvim",
-- 	dependencies = { "nvim-lua/plenary.nvim" },
-- 	config = function()
-- 		local rest_client = require("rest-nvim")
--
-- 		rest_client.setup {
-- 			-- Open request results in a horizontal split
-- 			result_split_horizontal = false,
-- 			-- Keep the http file buffer above|left when split horizontal|vertical
-- 			result_split_in_place = false,
-- 			-- Skip SSL verification, useful for unknown certificates
-- 			skip_ssl_verification = false,
-- 			-- Encode URL before making request
-- 			encode_url = true,
-- 			-- Highlight request on run
-- 			highlight = {
-- 				enabled = true,
-- 				timeout = 150,
-- 			},
-- 			result = {
-- 				-- toggle showing URL, HTTP info, headers at top the of result window
-- 				show_url = true,
-- 				-- show the generated curl command in case you want to launch
-- 				-- the same request via the terminal (can be verbose)
-- 				show_curl_command = false,
-- 				show_http_info = true,
-- 				show_headers = true,
-- 				-- executables or functions for formatting response body [optional]
-- 				-- set them to false if you want to disable them
-- 				formatters = {
-- 					json = "jq",
-- 					html = function(body)
-- 						return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
-- 					end
-- 				},
-- 			},
-- 			-- Jump to request line on run
-- 			jump_to_request = false,
-- 			env_file = '.env',
-- 			custom_dynamic_variables = {},
-- 			yank_dry_run = true,
-- 		}
--
-- 		vim.keymap.set('n', '<leader>rc', rest_client.run, { desc = '[R]un rest [Client]' })
-- 		vim.keymap.set('n', '<leader>rl', rest_client.last, { desc = '[R]un rest [Last] request' })
-- 	end
-- }
