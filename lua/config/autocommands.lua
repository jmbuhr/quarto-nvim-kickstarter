vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = { "*" },
  command = "checktime",
}
)

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "*" },
  command = "setlocal nonumber",
}
)

