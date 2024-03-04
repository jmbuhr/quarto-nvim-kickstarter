return {

	-- disables hungry features for files larget than 2MB
	{ "LunarVim/bigfile.nvim" },

	-- add/delete/change can be done with the keymaps
	-- ys{motion}{char}, ds{char}, and cs{target}{replacement}
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
			require("nvim-autopairs").remove_rule("`")
		end,
	},

	-- commenting with e.g. `gcc` or `gcip`
	-- respects TS, so it works in quarto documents
	{
		"numToStr/Comment.nvim",
		version = nil,
		branch = "master",
		config = true,
	},

	{ -- generate docstrings
		"danymat/neogen",
		enabled = false,
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
	},

	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
		submodules = false, -- not needed, submodules are required only for tests
		opts = {
			handler_options = {
				-- you can select between google, bing, duckduckgo, and ecosia
				search_engine = "duckduckgo",
			},
		},
	},

	{
		"folke/flash.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			modes = {
				search = {
					enabled = false,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
			},
			{
				"S",
				mode = { "o", "x" },
				function()
					require("flash").treesitter()
				end,
			},
		},
	},

	-- interactive global search and replace
	{
		"nvim-pack/nvim-spectre",
		cmd = { "Spectre" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
