return {
  -- common dependencies
  { 'nvim-lua/plenary.nvim' },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      styles = {},
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = false },
    },
  },
}
