return {
  -- common dependencies
  { 'nvim-lua/plenary.nvim' },
  {
    "folke/snacks.nvim",
    dev = true,
    priority = 1000,
    lazy = false,
    opts = {
      styles = {},
      bigfile = { notify = false },
      quickfile = {},
      picker = {
        -- ui_select = false, -- replace `vim.ui.select` with the snacks picker
      },
      indent = {}
    },
  },
}
