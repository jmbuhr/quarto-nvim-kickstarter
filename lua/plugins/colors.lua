return {
  { 'shaunsingh/nord.nvim' },
  { 'folke/tokyonight.nvim' },
  { 'EdenEast/nightfox.nvim' },
  { "catppuccin/nvim", name = "catppuccin", config = function()
    require("catppuccin").setup {
      flavour = "mocha", -- mocha, macchiato, frappe, latte
      term_colors = true,
      integrations = {
        nvimtree = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true
      },
      transparent_background = false,
    }
    vim.cmd.colorscheme 'catppuccin'
    local colors = require('catppuccin.palettes.mocha')
    vim.api.nvim_set_hl(0, 'Tabline', {fg = colors.green, bg = colors.mantle})
    vim.api.nvim_set_hl(0, 'TermCursor', {fg =  '#A6E3A1', bg = '#A6E3A1'})
  end
  },

  -- color html colors
  { 'norcalli/nvim-colorizer.lua', config = function()
    require 'colorizer'.setup {
      css = {
        css_fn = true,
        css = true,
        names = true,
      },
      'javascript',
      'html',
      'r',
      'rmd',
      'qmd',
      'markdown',
      'python'
    }
  end
  },
}
