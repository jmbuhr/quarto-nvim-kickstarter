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
---vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

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
    vim.cmd [[Catppuccin frappe]]
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

--show kepbindings with whichkey
--add your own here if you want them to
--show up in the popup as well
wk.add(
{
    { "<leader><cr>", "<Plug>SlimeSendCell", desc = "Run cell"},
    { "<leader>c", group = "code" },
    { "<leader>cc", ":SlimeSendCurrentLine<cr>", desc = "run line" },
    { "<leader>cvi", ":vsplit term://ipython<cr>", desc = "new ipython terminal" },
    { "<leader>cvn", ":vsplit term://$SHELL<cr>", desc = "new terminal" },
    { "<leader>cvp", ":vsplit term://python<cr>", desc = "new python terminal" },
    { "<leader>cvr", ":vsplit term://R<cr>", desc = "new R terminal" },
    { "<leader>cti", ":tabnew term://ipython<cr>", desc = "new ipython terminal" },
    { "<leader>ctn", ":tabnew term://$SHELL<cr>", desc = "new terminal" },
    { "<leader>ctp", ":tabnew term://python<cr>", desc = "new python terminal" },
    { "<leader>ctr", ":tabnew term://R<cr>", desc = "new R terminal" },
    { "<leader>cs", ":echo b:terminal_job_id<cr>", desc = "show terminal id" },

    { "<leader>d", group = "add chunck"},
    { "<leader>dc", "<Plug>SlimeSendCell", desc = "run cell" },
    { "<leader>dr", "o```{r}<cr>```<esc>O", desc = "r code chunk"},
    { "<leader>dp", "o```{python}<cr>```<esc>O", desc = "python code chunk"},

    { "<leader>f", group = "find (telescope)" },
    { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "man pages" },
    { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "fuzzy" },
    { "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "git commits" },
    { "<leader>fd", "<cmd>Telescope buffers<cr>", desc = "buffers" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "help" },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "marks" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "keymaps" },
    { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "loclist" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "marks" },
    { "<leader>fp", "<cmd>Telescope project<cr>", desc = "project" },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "quickfix" },

    { "<leader>q", group = "quarto" },
    { "<leader>qr", ":!quarto render % <cr>", desc = "render" },
    { "<leader>qp", ":!quarto preview % <cr>", desc = "preview" },
    { "<leader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "close" },

    { "<leader>v", group = "vim" },
    { "<leader>vl", ":Lazy<cr>", desc = "Lazy" },
    { "<leader>vs", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>", desc = "Settings" },
    { "<leader>vt", switchTheme, desc = "switch theme" },

    { "<leader>w", group = "write" },
    { "<leader>ww", ":w<cr>", desc = "write" },

    { "<leader>t", group = "tab"},
    { "<leader>tn", ":tabnew<cr>", desc = "[n]ew tab" },
    { "<leader>tc", ":tabclose<cr>", desc = "[c]lose tab" },
    { "<leader>to", ":tabonly<cr>", desc = "close [o]ther tabs" },
    { "<leader>ts", ":tab split<cr>", desc = "[s]plit tab" },
    { "<leader>te", ":tabnext<cr>", desc = "n[e]xt tab" },
  }
)

-- normal mode
wk.add({
    { "<c-q>", "<cmd>q<cr>", desc = "close buffer" },
    { "<cm-i>", "o```{python}<cr>```<esc>O", desc = "python code chunk" },
    { "<esc>", "<cmd>noh<cr>", desc = "remove search highlight" },
    { "<m-I>", "o```{python}<cr>```<esc>O", desc = "python code chunk" },
    { "<m-i>", "o```{r}<cr>```<esc>O", desc = "r code chunk" },
    { "cO", "O#%%<cr>", desc = "new code chunk above" },
    { "co", "o#%%<cr>", desc = "new code chunk below" },
    { "gN", "Nzzzv", desc = "center search" },
    { "gf", ":e <cfile><CR>", desc = "edit file" },
    { "gl", "<c-]>", desc = "open help link" },
    { "gx", ":!xdg-open <c-r><c-a><cr>", desc = "open file" },
    { "n", "nzzzv", desc = "center search" },
  })


-- visual mode
wk.add({
    { "<cr>", "<Plug>SlimeRegionSend", desc = "run code region", mode = "v" },
    { "<leader><leader>", "<Plug>SlimeRegionSend", desc = "run code region", mode = "v" },
  }
)

wk.add({
    {
      mode = { "i" },
      { "<cm-i>", "<esc>o```{python}<cr>```<esc>O", desc = "r code chunk" },
      { "<m-->", " <- ", desc = "assign" },
      { "<m-I>", "<esc>o```{python}<cr>```<esc>O", desc = "r code chunk" },
      { "<m-i>", "<esc>o```{r}<cr>```<esc>O", desc = "r code chunk" },
      { "<m-m>", " %>%", desc = "pipe" },
    },
  })


