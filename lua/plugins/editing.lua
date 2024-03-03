return {
  {
    "LunarVim/bigfile.nvim",
    init = function()
      -- default config
      require("bigfile").setup({
        filesize = 2,      -- size of the file in MiB, the plugin round file sizes to the closest MiB
        pattern = { "*" }, -- autocmd pattern
        features = {       -- features to disable
          "indent_blankline",
          "illuminate",
          "lsp",
          "treesitter",
          "syntax",
          "matchparen",
          "vimopts",
          "filetype",
        },
      })
    end,
  },
  { "tpope/vim-repeat" },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
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
    config = true, -- default settings
  },
  {
    "danymat/neogen",
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
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
