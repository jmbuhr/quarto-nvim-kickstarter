return {
  -- common dependencies
  { 'nvim-lua/plenary.nvim' },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      styles = {},
      bigfile = { enabled = true, notify = false },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      picker = {}
    },
  },
}
