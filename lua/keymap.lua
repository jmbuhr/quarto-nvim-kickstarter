local wk = require("which-key")

local nmap = function(key, effect)
  vim.keymap.set('n', key, effect, {silent = true, noremap = true})
end

local vmap = function(key, effect)
  vim.keymap.set('v', key, effect, {silent = true, noremap = true})
end

local imap = function(key, effect)
  vim.keymap.set('i', key, effect, {silent = true, noremap = true})
end

-- send code with ctrl+Enter
-- just like in e.g. RStudio
-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
nmap('<c-cr>', '<Plug>SlimeSendCell')
nmap('<s-cr>', '<Plug>SlimeSendCell')
imap('<c-cr>', '<esc><Plug>SlimeSendCell<cr>i')
imap('<s-cr>', '<esc><Plug>SlimeSendCell<cr>i')

-- send code with Enter and leader Enter
vmap('<cr>', '<Plug>SlimeRegionSend')
nmap('<leader><cr>', '<Plug>SlimeSendCell')


-- configure code sending, change where to send
-- speak: leader-code-configure
nmap('<leader>cc', '<Plug>SlimeConfig')

nmap('<c-b>', '<cmd>NvimTreeToggle<cr>')

-- source entire file
nmap('<leader>xx', ':w<cr>:source %<cr>')

-- keep selection after indent/dedent
vmap('>', '>gv')
vmap('<', '<gv')

-- remove search highlight on esc
nmap('<esc>','<cmd>noh<cr>')

-- find things with telescope
nmap('<leader>ff', "<cmd>Telescope git_files<cr>")
nmap('<leader>fa', "<cmd>Telescope find_files<cr>")
nmap('<leader>fh', "<cmd>Telescope help_tags<cr>")
nmap('<c-p>', "<cmd>Telescope find_files<cr>")

-- terminal mode
-- get out ouf terminal insert mode with esc
vim.keymap.set('t', '<esc>', [[<c-\><c-n>]], {silent = true, noremap = true})

-- diagnostic
nmap('<leader>dd', vim.diagnostic.disable)
nmap('<leader>ds', vim.diagnostic.enable)

-- lsp
-- nmap('<leader>lr', vim.lsp.buf.references)
nmap('<leader>ld',vim.lsp.buf.type_definition)
nmap('<leader>lR',vim.lsp.buf.rename)
nmap('<leader>la',vim.lsp.buf.code_action)
nmap('<leader>ld',vim.diagnostic.open_float)


-- open quarto preview
nmap('<leader>qp', require'quarto'.quartoPreview)


--show kepbindings with whichkey
--add your own here if you want them to
--show up in the popup as well
wk.register({
    l = {
      name = 'language/lsp',
      r = {'<cmd>Telescope lsp_references<cr>', 'references'},
      R = {vim.lsp.buf.rename, 'rename'},
      a = {vim.lsp.buf.code_action, 'coda action'},
      d = {vim.diagnostic.open_float , 'diagnostics'},
    },
  },
  {mode = 'n', prefix = '<leader>'}
)
