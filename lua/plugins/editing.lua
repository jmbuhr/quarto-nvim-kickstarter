return {
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  { 'windwp/nvim-autopairs', config = function()
    require('nvim-autopairs').setup {}
  end
  },
  -- commenting with e.g. `gcc` or `gcip`
  -- respects TS, so it works in quarto documents
  { 'numToStr/Comment.nvim',
    version = nil,
    branch = 'master',
    config = function()
    require('Comment').setup {}
  end
  },
  { "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true
  }
}
