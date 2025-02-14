vim.b.slime_cell_delimiter = '#\\s\\=%%'


local start_hamilton_lsp = function()
  local client = vim.lsp.start_client({
    cmd = { 'hamilton-lsp' },
    filetypes = { 'python' },
    on_attach = require('config.lsp').on_attach,
    root_dir = require('lspconfig').util.root_pattern('.git', 'setup.py'),
  })
end

start_hamilton_lsp()
