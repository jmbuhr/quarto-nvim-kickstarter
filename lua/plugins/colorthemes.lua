return {
	{ "shaunsingh/nord.nvim", enabled = false, lazy = false, priority = 1000 },
	{ "folke/tokyonight.nvim", enabled = false, lazy = false, priority = 1000 },
	{ "EdenEast/nightfox.nvim", enabled = false, lazy = false, priority = 1000 },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	{
		"olimorris/onedarkpro.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
	},

	-- color html colors
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "*" },
			RGB = true, -- #RGB hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			names = true, -- "Name" codes like Blue or blue
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = false, -- 0xAARRGGBB hex codes
			rgb_fn = false, -- CSS rgb() and rgba() functions
			hsl_fn = false, -- CSS hsl() and hsla() functions
			css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			-- Available modes for `mode`: foreground, background,  virtualtext
			mode = "background", -- Set the display mode.
			-- Available methods are false / true / "normal" / "lsp" / "both"
			-- True is same as normal
			tailwind = false, -- Enable tailwind colors
			-- parsers can contain values used in |user_default_options|
			sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
			virtualtext = "■",
			-- update color values even if buffer is not focused
			-- example use: cmp_menu, cmp_docs
			always_update = false,
			-- all the sub-options of filetypes apply to buftypes
			buftypes = {},
		},
	},
}
