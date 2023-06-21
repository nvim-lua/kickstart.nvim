return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require('neo-tree').setup {
			window = {
				position = "float",
				popup = {
					-- settings that apply to float position only
					size = { height = "20", width = "95" },
					-- 50% means center it
					position = "50%",
				},
			},
			default_component_configs = {
				container = {
					enable_character_fade = true
				},
				indent = {
					indent_size = 2,
					padding = 1, -- extra padding on left hand side
					-- indent guides
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					-- expander config, needed for nesting files
					with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "ﰊ",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = "*",
					highlight = "NeoTreeFileIcon"
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- Change type
						added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted   = "✖", -- this can only be used in the git_status source
						renamed   = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored   = "",
						unstaged  = "󰄱",
						staged    = "",
						conflict  = "",
					}
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					show_hidden_count = true,
					hide_by_name = {
					},
					never_show = {
						".git",
						".idea",
						".DS_Store",

					},
				},
			},
		}
		vim.keymap.set("n", "<leader>pw" , "<CMD>Neotree toggle<CR>")
		vim.keymap.set("n", "<leader>cw", "<CMD>Neotree focus<CR>")
	end,
}
