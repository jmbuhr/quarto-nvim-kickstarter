return {
  { "catppuccin/nvim", name = "catppuccin", config = function()
    require("catppuccin").setup {
      flavour = "frappe", -- mocha, macchiato, frappe, latte
      term_colors = true,
      integrations = {
        nvimtree = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true
      }
    }
    vim.cmd.colorscheme 'catppuccin'
    local colors = require('catppuccin.palettes.frappe')
    vim.cmd.highlight { 'Tabline', 'guifg=' .. colors.green, 'guibg=' .. colors.mantle }
  end
  },
}
