
vim.g.markdown_fenced_languages = { 'html', 'python', 'bash=sh', 'R=r' }
vim.opt.termguicolors = true

-- more opinionated
vim.opt.number = true -- show linenumbers
vim.opt.timeoutlen = 400 -- until which-key pops up
vim.opt.updatetime = 250 -- for autocommands and hovers
vim.opt.mouse= 'a' -- enable mouse
vim.opt.mousefocus = true
vim.opt.clipboard:append 'unnamedplus' -- use system clipboard

-- use spaces as tabs
local tabsize = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = tabsize
vim.opt.tabstop = tabsize

-- space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- colortheme tweaks
vim.g.nord_borders = true

-- indent
vim.opt.smartindent = true
vim.opt.breakindent = true

-- consisten number column
vim.opt.signcolumn = "yes:1"

-- how to show a autocomplete menu
vim.opt.completeopt = 'menuone,noinsert'
