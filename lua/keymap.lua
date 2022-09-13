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


-- source entire file
nmap('<leader>xx', ':w<cr>:source %<cr>')

-- keep selection after indent/dedent
vmap('>', '>gv')
vmap('<', '<gv')

-- remove search highlight on esc
nmap('<esc>','<cmd>noh<cr>')

-- find files with telescope
nmap('<c-p>', "<cmd>Telescope find_files<cr>")

-- paste and without overwriting register
vmap("<leader>p", "\"_dP")


-- terminal mode
-- get out ouf terminal insert mode with esc
vim.keymap.set('t', '<esc>', [[<c-\><c-n>]], {silent = true, noremap = true})

-- open filetree
nmap('<c-b>', '<cmd>NvimTreeToggle<cr>')

-- move between splits and tabs
nmap('<c-h>', '<c-w>h')
nmap('<c-l>', '<c-w>l')
nmap('<c-j>', '<c-w>j')
nmap('<c-k>', '<c-w>k')
nmap('H', '<cmd>tabprevious<cr>')
nmap('L', '<cmd>tabnext<cr>')


--show kepbindings with whichkey
--add your own here if you want them to
--show up in the popup as well
wk.register({
  l = {
    name = 'language/lsp',
    r = {'<cmd>Telescope lsp_references<cr>', 'references'},
    R = {vim.lsp.buf.rename, 'rename'},
    D = {vim.lsp.buf.type_definition, 'type definition'},
    a = {vim.lsp.buf.code_action, 'coda action'},
    e = {vim.diagnostic.open_float , 'diagnostics'},
    f = {vim.lsp.buf.format, 'format'},
    d  = {
      name = 'diagnostics',
      d = {vim.diagnostic.disable, 'disable'},
      e = {vim.diagnostic.enable, 'enable'},
    },
  },
  d = {
    name = "debug",
    b = { ":lua require'dap'.toggle_breakpoint()<CR>", "breakpoint" },
    B = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "breakpoint condition" },
    l = { ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "log point" },
    r = { ":lua require'dap'.repl.open()<cr>", "repl" },
    u = { ":lua require'dapui'.toggle()<cr>", "ui" },
    c = { ":lua require'dap'.continue()<cr>", "continue" },
    so = { ":lua require'dap'.step_over()<cr>", "step over" },
    si = { ":lua require'dap'.step_into()<cr>", "step into" },
    st = { ":lua require'dap'.step_out()<cr>", "step out" },
    h = { ":lua require('dap-python').test_method()<cr>", "debug here" },
  },
  q = {
    name = 'quarto',
    p = {require'quarto'.quartoPreview, 'preview'}
  },
  f = {
    name = 'find (telescope)',
    f = {'<cmd>Telescope find_files<cr>', 'files'},
    h = {'<cmd>Telescope help_tags<cr>', 'help'},
    k = {'<cmd>Telescope keymaps<cr>', 'keymaps'},
    r = {'<cmd>Telescope lsp_references<cr>', 'references'},
    g = { "<cmd>Telescope live_grep<cr>", "grep" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "fuzzy" },
    m = { "<cmd>Telescope marks<cr>", "marks" },
    M = { "<cmd>Telescope man_pages<cr>", "man pages" },
    c = { "<cmd>Telescope git_commits<cr>", "git commits" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "symbols" },
    t = { "<cmd>Telescope tmux sessions<cr>", "tmux session" },
    w = { "<cmd>Telescope tmux windows<cr>", "tmux window" },
    d = { "<cmd>Telescope buffers<cr>", "buffers" },
    q = { "<cmd>Telescope quickfix<cr>", "quickfix" },
    l = { "<cmd>Telescope loclist<cr>", "loclist" },
    j = { "<cmd>Telescope jumplist<cr>", "marks" },
    p = { "<cmd>Telescope project<cr>", "project" },
  },
  s = {
    name = "spellcheck",
    s = { "<cmd>Telescope spell_suggest<cr>", "spelling" },
    ['/'] = { '<cmd>setlocal spell!<cr>', 'spellcheck' },
    n = { ']s', 'next' },
    p = {'[s', 'previous'},
    g = {'zg', 'good'},
    a = {'zg', 'accept'},
    b = {'zb', 'bad'},
    ['?'] = { '<cmd>Telescope spell_suggest<cr>', 'suggest' },
  },
  },
  {mode = 'n', prefix = '<leader>'}
)
