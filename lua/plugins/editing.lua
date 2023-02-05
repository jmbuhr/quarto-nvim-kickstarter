return {
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  { 'lukas-reineke/indent-blankline.nvim', config = function()
    require("indent_blankline").setup {
      show_current_context = true,
      show_current_context_start = false,
    }
  end
  },
  -- commenting with e.g. `gcc` or `gcip`
  -- respects TS, so it works in quarto documents
  { 'jmbuhr/Comment.nvim', config = function()
    require('Comment').setup {}
  end
  },
  { "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true
  }
}
