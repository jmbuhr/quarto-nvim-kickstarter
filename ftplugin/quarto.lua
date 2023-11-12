vim.b.slime_cell_delimiter = "```"

-- wrap text, but by word no character
-- indent the wrappped line
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.showbreak = "|"

-- don't run vim ftplugin on top
vim.api.nvim_buf_set_var(0, "did_ftplugin", true)


local nmap = function(key, effect)
	vim.keymap.set("n", key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
	vim.keymap.set("v", key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
	vim.keymap.set("i", key, effect, { silent = true, noremap = true })
end

local runner = require'quarto.runner'

 -- runner.run_cell,
 -- runner.run_above,
 -- runner.run_below, {})
 -- runner.run_all, {})
 -- runner.run_range, { range = 2 })
 -- runner.run_line, {})

-- send code with ctrl+Enter
-- just like in e.g. RStudio
-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
nmap("<c-cr>", runner.run_cell)
nmap("<s-cr>", runner.run_cell)
imap("<c-cr>", runner.run_cell)
imap("<s-cr>", runner.run_cell)
vmap("<cr>", runner.run_range)
