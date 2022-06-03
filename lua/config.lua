
vim.g.markdown_fenced_languages = { 'html', 'python', 'bash=sh', 'R=r' }
vim.opt.termguicolors = true

-- mor opinionated
vim.opt.number = true -- show linenumbers
vim.opt.updatetime = 250 -- for autocommands and hovers
vim.opt.mouse= 'a' -- enable mouse
vim.opt.mousefocus = true
vim.opt.clipboard:append 'unnamedplus' -- use system clipboard
-- use spaces as tabs
local tabsize = 2
vim.opt.shiftwidth = tabsize
vim.opt.tabstop = tabsize
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.smartcase = true
