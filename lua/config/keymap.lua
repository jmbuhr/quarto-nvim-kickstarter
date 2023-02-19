local wk = require("which-key")

P = function(x)
  print(vim.inspect(x))
  return (x)
end

RELOAD = function(...)
  return require 'plenary.reload'.reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

-- save in insert mode
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><esc>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr><esc>")

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Move between windows using <ctrl> direction
vim.keymap.set("n", '<C-j>', '<C-W>j')
vim.keymap.set("n", '<C-k>', '<C-W>k')
vim.keymap.set("n", '<C-h>', '<C-W>h')
vim.keymap.set("n", '<C-l>', '<C-W>l')

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")


function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local nmap = function(key, effect)
  vim.keymap.set('n', key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
  vim.keymap.set('v', key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
  vim.keymap.set('i', key, effect, { silent = true, noremap = true })
end

local function switchTheme()
  if vim.o.background == 'light' then
    vim.o.background = 'dark'
    vim.cmd [[Catppuccin mocha]]
  else
    vim.o.background = 'light'
    vim.cmd [[Catppuccin latte]]
  end
end

nmap('Q', '<Nop>')

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

-- list hidden buffers
nmap('<leader>ls', ':ls!<cr>')
nmap('<leader>vh', ':execute "h " . expand("<cword>")<cr>')

-- source entire file
nmap('<leader>xx', ':w<cr>:source %<cr>')

-- keep selection after indent/dedent
vmap('>', '>gv')
vmap('<', '<gv')

-- remove search highlight on esc
nmap('<esc>', '<cmd>noh<cr>')

-- find files with telescope
nmap('<c-p>', "<cmd>Telescope find_files<cr>")

-- paste and without overwriting register
vmap("<leader>p", "\"_dP")

-- delete and without overwriting register
vmap("<leader>d", "\"_d")

-- center after search and jumps
nmap('n', "nzz")
nmap('<c-d>', '<c-d>zz')
nmap('<c-u>', '<c-u>zz')


-- terminal mode
-- get out ouf terminal insert mode with esc
vim.keymap.set('t', '<esc>', [[<c-\><c-n>]], { silent = true, noremap = true })
--move to other window
vim.keymap.set('t', '<c-j>', [[<c-\><c-n><c-w>w]], { silent = true, noremap = true })
vim.keymap.set('n', '<leader>j', [[<c-w>wi]], { silent = true, noremap = true })

-- open filetree
nmap('<c-b>', '<cmd>NvimTreeToggle<cr>')

-- move between splits and tabs
nmap('<c-h>', '<c-w>h')
nmap('<c-l>', '<c-w>l')
nmap('<c-j>', '<c-w>j')
nmap('<c-k>', '<c-w>k')
nmap('H', '<cmd>tabprevious<cr>')
nmap('L', '<cmd>tabnext<cr>')

local function open_plugin()
  local word = vim.fn.expand('<cWORD>')
  -- url = string.match(url, '".+"')
  local url = string.match(word, '%b""')
  if url ~= nil then
    url = string.gsub(url, '["\']', '')
  else
    url = string.match(word, "%b''")
    if url ~= nil then
      url = string.gsub(url, '["\']', '')
    end
  end
  url = 'https://github.com/' .. url
  local cmd = "!brave-browser " .. url
  vim.cmd(cmd)
end

--show kepbindings with whichkey
--add your own here if you want them to
--show up in the popup as well
wk.register(
  {
    c = {
      name = 'code',
      c = { ':SlimeConfig<cr>', 'slime config' },
      n = {  ':split term://$SHELL<cr>', 'new terminal' },
      r = {  ':split term://R<cr>', 'new R terminal' },
      p = {  ':split term://python<cr>', 'new python terminal' },
      i = {  ':split term://ipython<cr>', 'new ipython terminal' },
      j = {  ':split term://julia<cr>', 'new julia terminal' },
      s = {  ':echo b:terminal_job_id<cr>', 'show terminal id' },
    },
    v = {
      name = 'vim',
      p = {open_plugin, 'open plugin'},
      t = { switchTheme, 'switch theme' },
      c = { ':Telescope colorscheme<cr>', 'colortheme' },
      l = { ':Lazy<cr>', 'Lazy' },
      m = { ':Mason<cr>', 'Mason' },
      s = { ':e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>', 'Settings' },
    },
    l = {
      name = 'language/lsp',
      r    = { '<cmd>Telescope lsp_references<cr>', 'references' },
      R    = { vim.lsp.buf.rename, 'rename' },
      D    = { vim.lsp.buf.type_definition, 'type definition' },
      a    = { vim.lsp.buf.code_action, 'coda action' },
      e    = { vim.diagnostic.open_float, 'diagnostics' },
      f    = { vim.lsp.buf.format, 'format' },
      o    = { ':SymbolsOutline<cr>', 'outline' },
      d    = {
        name = 'diagnostics',
        d = { vim.diagnostic.disable, 'disable' },
        e = { vim.diagnostic.enable, 'enable' },
      },
      g = { ':Neogen<cr>', 'neogen docstring'}
    },
    q = {
      name = 'quarto',
      a = { ":QuartoActivate<cr>", 'activate' },
      p = { ":lua require'quarto'.quartoPreview()<cr>", 'preview' },
      q = { ":lua require'quarto'.quartoClosePreview()<cr>", 'close' },
      h = { ":QuartoHelp ", 'help' },
      e = { ":lua require'otter'.export()<cr>", 'export' },
      E = { ":lua require'otter'.export(true)<cr>", 'export overwrite' },
    },
    f = {
      name = 'find (telescope)',
      f = { '<cmd>Telescope find_files<cr>', 'files' },
      h = { '<cmd>Telescope help_tags<cr>', 'help' },
      k = { '<cmd>Telescope keymaps<cr>', 'keymaps' },
      r = { '<cmd>Telescope lsp_references<cr>', 'references' },
      g = { "<cmd>Telescope live_grep<cr>", "grep" },
      b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "fuzzy" },
      m = { "<cmd>Telescope marks<cr>", "marks" },
      M = { "<cmd>Telescope man_pages<cr>", "man pages" },
      c = { "<cmd>Telescope git_commits<cr>", "git commits" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "symbols" },
      d = { "<cmd>Telescope buffers<cr>", "buffers" },
      q = { "<cmd>Telescope quickfix<cr>", "quickfix" },
      l = { "<cmd>Telescope loclist<cr>", "loclist" },
      j = { "<cmd>Telescope jumplist<cr>", "marks" },
      p = { "project" },
    },
    h = {
      name = 'hidden',
      h = {':set conceallevel=1<cr>', 'hide/conceal'},
      s = {':set conceallevel=0<cr>', 'show/unconceal'},
    },
    s = {
      name = "spellcheck",
      s = { "<cmd>Telescope spell_suggest<cr>", "spelling" },
      ['/'] = { '<cmd>setlocal spell!<cr>', 'spellcheck' },
      n = { ']s', 'next' },
      p = { '[s', 'previous' },
      g = { 'zg', 'good' },
      r = { 'zg', 'rigth' },
      w = { 'zw', 'wrong' },
      b = { 'zw', 'bad' },
      ['?'] = { '<cmd>Telescope spell_suggest<cr>', 'suggest' },
    },
    g = {
      name = "git",
      c = { ":GitConflictRefresh<cr>", 'conflict' },
      g = { ":Neogit<cr>", "neogit" },
      s = { ":Gitsigns<cr>", "gitsigns" },
      pl = { ":Octo pr list<cr>", "gh pr list" },
      pr = { ":Octo review start<cr>", "gh pr review" },
      wc = { ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "worktree create" },
      ws = { ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "worktree switch" },
      d = {
        name = 'diff',
        o = { ':DiffviewOpen<cr>', 'open' },
        c = { ':DiffviewClose<cr>', 'close' },
      }
    },
    w = {
      name = 'write',
      w = { ":w<cr>", "write" },
    },
  }, { mode = 'n', prefix = '<leader>' }
)

-- normal mode
wk.register({
  ['<c-LeftMouse>'] = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'go to definition' },
  ['gx']            = { ':!xdg-open <c-r><c-a><cr>', 'open file' },
  ["<c-q>"]         = { '<cmd>q<cr>', 'close buffer' },
  ['<esc>']         = { '<cmd>noh<cr>', 'remove search highlight' },
  ['n']             = { 'nzzzv', 'center search' },
  ['gN']            = { 'Nzzzv', 'center search' },
  ['gl']            = { '<c-]>', 'open help link' },
  ['gf']            = { ':e <cfile><CR>', 'edit file' },
  ['co']            = { 'o#%%<cr>', 'new code chunk below' },
  ['cO']            = { 'O#%%<cr>', 'new code chunk above' },
  ['<m-i>']         = { 'o```{r}<cr>```<esc>O', "r code chunk" },
  ['<cm-i>']        = { 'o```{python}<cr>```<esc>O', "r code chunk" },
  ['<m-I>']         = { 'o```{python}<cr>```<esc>O', "r code chunk" },
}, { mode = 'n' })

-- visual mode
wk.register({
  ['<cr>'] = { '<Plug>SlimeRegionSend', 'run code region' },
  ['gx'] = { '"ty:!xdg-open t<cr>', 'open file' },
  ['<M-j>'] = { ":m'>+<cr>`<my`>mzgv`yo`z", 'move line down' },
  ['<M-k>'] = { ":m'<-2<cr>`>my`<mzgv`yo`z", 'move line up' },
  ['.'] = { ':norm .<cr>', 'repat last normal mode command' },
  ['q'] = { ':norm @q<cr>', 'repat q macro' },
}, { mode = 'v' })

wk.register({
  ['<leader>'] = { '<Plug>SlimeRegionSend', 'run code region' },
  ['p'] = { '"_dP', 'replace without overwriting reg' },
}, { mode = 'v', prefix = "<leader>" })

wk.register({
  -- ['<c-e>'] = { "<esc>:FeMaco<cr>i", "edit code" },
  ['<m-->'] = { ' <- ', "assign" },
  ['<m-m>'] = { ' |>', "pipe" },
  ['<m-i>'] = { '```{r}<cr>```<esc>O', "r code chunk" },
  ['<cm-i>'] = { '<esc>o```{python}<cr>```<esc>O', "r code chunk" },
  ['<m-I>'] = { '<esc>o```{python}<cr>```<esc>O', "r code chunk" },
}, { mode = 'i' })
