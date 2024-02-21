vim.b.slime_cell_delimiter = "```"
vim.b["quarto_is_r_mode"] = nil

-- wrap text, but by word no character
-- indent the wrappped line
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.showbreak = "|"

-- don't run vim ftplugin on top
vim.api.nvim_buf_set_var(0, "did_ftplugin", true)
