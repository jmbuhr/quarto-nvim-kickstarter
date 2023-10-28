return {
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  
  { 'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} }, 
  -- commenting with e.g. `gcc` or `gcip`
  -- respects TS, so it works in quarto documents
  { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup {}
  end
  },
}
