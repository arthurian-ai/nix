local transparentTokyoNightMoon = {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		on_colors = function(c)
			-- Because lualine broke stuff with the latest commit
			c.bg_statusline = c.none
		end,
		on_highlights = function(hl, c)
			-- TabLineFill is currently set to black
			hl.TabLineFill = {
				bg = c.none,
			}
		end,
	},
}

local tokyoNightNight = {
	"folke/tokyonight.nvim",
	opts = {
		style = "night",
	},
}

local transparentTokyoNightNight = {
	"folke/tokyonight.nvim",
	opts = {
		transparent = true,
		style = "night",
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
	},
}

local nordic = {
	"AlexvZyl/nordic.nvim",
}

local rosePine = {
	"rose-pine/neovim",
	name = "rose-pine",
}

local transparentCatppuccin = {
	{
		"catppuccin/nvim",
		priority = 1000,
		name = "catppuccin",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			transparent_background = true,
			-- on_colors = function(colors)
			-- 	colors.bg_statusline = "NONE"
			-- end,
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				fzf = true,
				grug_far = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				leap = true,
				lsp_trouble = true,
				mason = true,
				markdown = true,
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				snacks = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		},
	},
	specs = {
		{
			"akinsho/bufferline.nvim",
			optional = true,
			opts = function(_, opts)
				if (vim.g.colors_name or ""):find("catppuccin") then
					opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
				end
			end,
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},
}

--     {
-- 	{
-- 		"LazyVim/LazyVim",
-- 		opts = {
-- 			colorscheme = "catppuccin",
-- 		},
-- 	},
-- 	{
-- 		"catppuccin/nvim",
-- 		lazy = true,
-- 		name = "catppuccin",
-- 		opts = {
-- 			integrations = {
-- 				aerial = true,
-- 				alpha = true,
-- 				cmp = true,
-- 				dashboard = true,
-- 				flash = true,
-- 				fzf = true,
-- 				grug_far = true,
-- 				gitsigns = true,
-- 				headlines = true,
-- 				illuminate = true,
-- 				indent_blankline = { enabled = true },
-- 				leap = true,
-- 				lsp_trouble = true,
-- 				mason = true,
-- 				markdown = true,
-- 				mini = true,
-- 				native_lsp = {
-- 					enabled = true,
-- 					underlines = {
-- 						errors = { "undercurl" },
-- 						hints = { "undercurl" },
-- 						warnings = { "undercurl" },
-- 						information = { "undercurl" },
-- 					},
-- 				},
-- 				navic = { enabled = true, custom_bg = "lualine" },
-- 				neotest = true,
-- 				neotree = true,
-- 				noice = true,
-- 				notify = true,
-- 				semantic_tokens = true,
-- 				snacks = true,
-- 				telescope = true,
-- 				treesitter = true,
-- 				treesitter_context = true,
-- 				which_key = true,
-- 			},
-- 		},
-- 		specs = {
-- 			{
-- 				"akinsho/bufferline.nvim",
-- 				optional = true,
-- 				opts = function(_, opts)
-- 					if (vim.g.colors_name or ""):find("catppuccin") then
-- 						opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
-- 					end
-- 				end,
-- 			},
-- 		},
-- 	},
-- }

-- return transparentTokyoNightMoon

-- return {
-- 	{ "catppuccin/nvim" },
-- 	{
-- 		"LazyVim/LazyVim",
-- 		opts = {
-- 			colorscheme = "catppuccin",
-- 		},
-- 	},
-- }

-- return {
-- 	{
-- 		"rose-pine/neovim",
-- 		name = "rose-pine",
-- 		opts = {
-- 			variant = "main",
-- 			palette = {
-- 				-- Override the builtin palette per variant
-- 				main = {
-- 					base = "#1C1A28",
-- 					-- overlay = '#363738',
-- 				},
-- 			},
-- 		},
-- 	},
-- 	{
-- 		"LazyVim/LazyVim",
-- 		opts = {
-- 			colorscheme = "rose-pine",
-- 		},
-- 	},
-- }

return {
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		opts = {
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "kanagawa",
		},
	},
}

-- return {
-- 	{
-- 		"AlexvZyl/nordic.nvim",
-- 		name = "nordic",
-- 	},
-- 	{
-- 		"LazyVim/LazyVim",
-- 		opts = {
-- 			colorscheme = "nordic",
-- 		},
-- 	},
-- }

-- return {
-- 	{ "ellisonleao/gruvbox.nvim" },
-- 	{
-- 		"LazyVim/LazyVim",
-- 		opts = {
-- 			colorscheme = "gruvbox",
-- 		},
-- 	},
-- }
