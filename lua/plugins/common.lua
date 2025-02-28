return {
  -- common dependencies
  { 'nvim-lua/plenary.nvim' },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      styles = {},
      bigfile = { notify = false },
      quickfile = {},
      picker = {},
      indent = {}
    },
  },
}
