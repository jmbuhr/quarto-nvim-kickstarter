return {
  { 'tpope/vim-repeat' },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
      require('nvim-autopairs').remove_rule('`')
    end
  },
  -- commenting with e.g. `gcc` or `gcip`
  -- respects TS, so it works in quarto documents
  {
    'numToStr/Comment.nvim',
    version = nil,
    branch = 'master',
    config = true, -- default settings
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true
  },
  {
    "chrishrb/gx.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true, -- default settings
  },
  {
    "ggandor/leap.nvim",
    event = { "BufEnter" },
    config = function()
      require('leap').add_default_mappings()
    end
  }
}
