
vim.cmd.colorscheme 'catppuccin'
local colors = require('catppuccin.palettes.mocha')
vim.api.nvim_set_hl(0, 'Tabline', { fg = colors.green, bg = colors.mantle })
vim.api.nvim_set_hl(0, 'TermCursor', { fg = '#A6E3A1', bg = '#A6E3A1' })
