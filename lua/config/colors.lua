
vim.cmd.colorscheme 'catppuccin'
local colors = require('catppuccin.palettes.frappe')
vim.cmd.highlight { 'Tabline', 'guifg=' .. colors.green, 'guibg=' .. colors.mantle }

