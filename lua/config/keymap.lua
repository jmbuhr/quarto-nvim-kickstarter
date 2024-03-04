local wk = require("which-key")

vim.g["quarto_is_r_mode"] = nil
vim.g["reticulate_running"] = false

local nmap = function(key, effect)
	vim.keymap.set("n", key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
	vim.keymap.set("v", key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
	vim.keymap.set("i", key, effect, { silent = true, noremap = true })
end

-- save with ctrl+s
imap("<C-s>", "<esc>:update<cr><esc>")
nmap("<C-s>", "<cmd>:update<cr><esc>")

-- Move between windows using <ctrl> direction
nmap("<C-j>", "<C-W>j")
nmap("<C-k>", "<C-W>k")
nmap("<C-h>", "<C-W>h")
nmap("<C-l>", "<C-W>l")

-- Resize window using <shift> arrow keys
nmap("<S-Up>", "<cmd>resize +2<CR>")
nmap("<S-Down>", "<cmd>resize -2<CR>")
nmap("<S-Left>", "<cmd>vertical resize -2<CR>")
nmap("<S-Right>", "<cmd>vertical resize +2<CR>")

-- Add undo break-points
imap(",", ",<c-g>u")
imap(".", ".<c-g>u")
imap(";", ";<c-g>u")

nmap("Q", "<Nop>")

--- Send code to terminal with vim-slime
--- If an R terminal has been opend, this is in r_mode
--- and will handle python code via reticulate when sent
--- from a python chunk.
local function send_cell()
	if vim.b["quarto_is_r_mode"] == nil then
		vim.cmd([[call slime#send_cell()]])
		return
	end
	if vim.b["quarto_is_r_mode"] == true then
		vim.g.slime_python_ipython = 0
		local is_python = require("otter.tools.functions").is_otter_language_context("python")
		if is_python and not vim.b["reticulate_running"] then
			vim.cmd([[call slime#send("reticulate::repl_python()" . "\r")]])
			vim.b["reticulate_running"] = true
		end
		if not is_python and vim.b["reticulate_running"] then
			vim.cmd([[call slime#send("exit" . "\r")]])
			vim.b["reticulate_running"] = false
		end
		vim.cmd([[call slime#send_cell()]])
	end
end

-- send code with ctrl+Enter
-- just like in e.g. RStudio
-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
nmap("<c-cr>", send_cell)
nmap("<s-cr>", send_cell)
imap("<c-cr>", send_cell)
imap("<s-cr>", send_cell)

-- send code with Enter and leader Enter
vmap("<cr>", "<Plug>SlimeRegionSend")
nmap("<leader><cr>", "<Plug>SlimeSendCell")

--- Show R dataframe in the browser
local function show_table()
	local node = vim.treesitter.get_node({ ignore_injections = false })
	local text = vim.treesitter.get_node_text(node, 0)
	local cmd = [[call slime#send("DT::datatable(]] .. text .. [[)" . "\r")]]
	vim.cmd(cmd)
end

-- might not use what you think should be your default web browser
-- because it is a plain html file, not a link
-- see https://askubuntu.com/a/864698 for places to look for
vim.keymap.set("n", "<leader>rt", show_table, { desc = "[r] show [t]able" })

-- keep selection after indent/dedent
vmap(">", ">gv")
vmap("<", "<gv")

-- center after search and jumps
nmap("n", "nzz")
nmap("<c-d>", "<c-d>zz")
nmap("<c-u>", "<c-u>zz")

-- move between splits and tabs
nmap("<c-h>", "<c-w>h")
nmap("<c-l>", "<c-w>l")
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("H", "<cmd>tabprevious<cr>")
nmap("L", "<cmd>tabnext<cr>")

local function toggle_light_dark_theme()
	if vim.o.background == "light" then
		vim.o.background = "dark"
		vim.cmd([[Catppuccin mocha]])
	else
		vim.o.background = "light"
		vim.cmd([[Catppuccin latte]])
	end
end

--show kepbindings with whichkey
--add your own here if you want them to
--show up in the popup as well
wk.register({
	r = { name = "[r] R specific tools" },
	c = {
		name = "[c]ode / [c]ell / [c]hunk",
		c = { ":SlimeConfig<cr>", "slime [c]onfig" },
		n = { ":vsplit term://$SHELL<cr>", "[n]ew terminal with shell" },
		r = {
			function()
				vim.b["quarto_is_r_mode"] = true
				vim.cmd("vsplit term://R")
			end,
			"new [R] terminal",
		},
		p = { ":vsplit term://python<cr>", "new [p]ython terminal" },
		i = { ":vsplit term://ipython<cr>", "new [i]python terminal" },
		j = { ":vsplit term://julia<cr>", "new [j]ulia terminal" },
		o = {
			name = "[o]open code chunk",
			r = { "o```{r}<cr>```<esc>O", "[r] code chunk" },
			p = { "o```{python}<cr>```<esc>O", "[p]ython code chunk" },
			j = { "o```{julia}<cr>```<esc>O", "[j]ulia code chunk" },
			b = { "o```{bash}<cr>```<esc>O", "[b]ash code chunk" },
			o = { "o```{ojs}<cr>```<esc>O", "[o]bservable js code chunk" },
			l = { "o```{lua}<cr>```<esc>O", "[l]lua code chunk" },
		},
	},
	i = {
		name = "[i]nsert",
		i = { ":PasteImage<cr>", "image from clipboard" },
	},
	v = {
		name = "[v]im",
		t = { toggle_light_dark_theme, "[t]oggle light/dark theme" },
		c = { ":Telescope colorscheme<cr>", "[c]olortheme" },
		l = { ":Lazy<cr>", "[l]azy package manager" },
		m = { ":Mason<cr>", "[m]ason software installer" },
		s = { ":e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>", "[s]ettings, edit vimrc" },
		h = { ':execute "h " . expand("<cword>")<cr>', "vim [h]elp for current word" },
	},
	l = {
		name = "[l]anguage/lsp",
		r = { "<cmd>Telescope lsp_references<cr>", "[r]eferences" },
		R = { "[R]ename" },
		D = { vim.lsp.buf.type_definition, "type [D]efinition" },
		a = { vim.lsp.buf.code_action, "codr [a]ction" },
		e = { vim.diagnostic.open_float, "diagnostics (show hover [e]rror)" },
		d = {
			name = "diagnostics",
			d = { vim.diagnostic.disable, "disable" },
			e = { vim.diagnostic.enable, "enable" },
		},
		g = { ":Neogen<cr>", "neogen docstring" },
		s = { ":ls!<cr>", "list all buffers" },
	},
	o = {
		name = "[o]tter & c[o]de",
		a = { require("otter").dev_setup, "otter activate" },
		["o"] = { "o# %%<cr>", "new code chunk below" },
		["O"] = { "O# %%<cr>", "new code chunk above" },
		["b"] = { "o```{bash}<cr>```<esc>O", "bash code chunk" },
		["r"] = { "o```{r}<cr>```<esc>O", "r code chunk" },
		["p"] = { "o```{python}<cr>```<esc>O", "python code chunk" },
		["j"] = { "o```{julia}<cr>```<esc>O", "julia code chunk" },
		["l"] = { "o```{julia}<cr>```<esc>O", "julia code chunk" },
	},
	q = {
		name = "[q]uarto",
		a = { ":QuartoActivate<cr>", "[a]ctivate" },
		p = { ":lua require'quarto'.quartoPreview()<cr>", "[p]review" },
		q = { ":lua require'quarto'.quartoClosePreview()<cr>", "[q]uiet preview" },
		h = { ":QuartoHelp ", "[h]elp" },
		r = {
			name = "[r]un",
			r = { ":QuartoSendAbove<cr>", "to cu[r]sor" },
			a = { ":QuartoSendAll<cr>", "run [a]ll" },
		},
		e = { ":lua require'otter'.export()<cr>", "[e]xport" },
		E = { ":lua require'otter'.export(true)<cr>", "[E]xport with overwrite" },
	},
	f = {
		name = "[f]ind (telescope)",
		f = { "<cmd>Telescope find_files<cr>", "[f]iles" },
		h = { "<cmd>Telescope help_tags<cr>", "[h]elp" },
		k = { "<cmd>Telescope keymaps<cr>", "[k]eymaps" },
		r = { "<cmd>Telescope lsp_references<cr>", "[r]eferences" },
		g = { "<cmd>Telescope live_grep<cr>", "[g]rep" },
		b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "[b]uffer fuzzy find" },
		m = { "<cmd>Telescope marks<cr>", "[m]arks" },
		M = { "<cmd>Telescope man_pages<cr>", "[M]an pages" },
		c = { "<cmd>Telescope git_commits<cr>", "git [c]ommits" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "document [s]ymbols" },
		["<space>"] = { "<cmd>Telescope buffers<cr>", "[ ] buffers" },
		d = { "<cmd>Telescope buffers<cr>", "[d] buffers" },
		q = { "<cmd>Telescope quickfix<cr>", "[q]uickfix" },
		l = { "<cmd>Telescope loclist<cr>", "[l]oclist" },
		j = { "<cmd>Telescope jumplist<cr>", "[j]umplist" },
	},
	h = {
		name = "[h]elp / [h]ide / debug",
		c = {
			name = "[c]onceal",
			h = { ":set conceallevel=1<cr>", "[h]ide/conceal" },
			s = { ":set conceallevel=0<cr>", "[s]how/unconceal" },
		},
		t = {
			name = "[t]reesitter",
			t = { vim.treesitter.inspect_tree, "show [t]ree" },
		},
	},
	g = {
		name = "[g]it",
		c = { ":GitConflictRefresh<cr>", "[c]onflict" },
		s = { ":Gitsigns<cr>", "git [s]igns" },
		wc = { ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "worktree create" },
		ws = { ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "worktree switch" },
		d = {
			name = "[d]iff",
			o = { ":DiffviewOpen<cr>", "[o]pen" },
			c = { ":DiffviewClose<cr>", "[c]lose" },
		},
		b = {
			name = "[b]lame",
			b = { ":GitBlameToggle<cr>", "[b]lame toggle virtual text" },
			o = { ":GitBlameOpenCommitURL<cr>", "[o]pen" },
			c = { ":GitBlameCopyCommitURL<cr>", "[c]opy" },
		},
	},
	x = {
		name = "e[x]ecute",
		x = { ":w<cr>:source %<cr>", "[x] source %" },
	},
}, { mode = "n", prefix = "<leader>" })

local is_code_chunk = function()
	local current, _ = require("otter.keeper").get_current_language_context()
	if current then
		return true
	else
		return false
	end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
	local keys
	if is_code_chunk() then
		keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
	else
		keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
	end
	keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

local insert_r_chunk = function()
	insert_code_chunk("r")
end

local insert_py_chunk = function()
	insert_code_chunk("python")
end

-- normal mode
wk.register({
	["<c-LeftMouse>"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "go to definition" },
	["<c-q>"] = { "<cmd>q<cr>", "close buffer" },
	["<esc>"] = { "<cmd>noh<cr>", "remove search highlight" },
	["n"] = { "nzzzv", "center search" },
	["gN"] = { "Nzzzv", "center search" },
	["gl"] = { "<c-]>", "open help link" },
	["gf"] = { ":e <cfile><CR>", "edit file" },
	["<m-i>"] = { insert_r_chunk, "r code chunk" },
	["<cm-i>"] = { insert_py_chunk, "python code chunk" },
	["<m-I>"] = { insert_py_chunk, "python code chunk" },
	["]q"] = { ":silent cnext<cr>", "quickfix next" },
	["[q"] = { ":silent cprev<cr>", "quickfix prev" },
	["z?"] = { ":setlocal spell!<cr>", "toggle spellcheck" },
}, { mode = "n", silent = true })

-- visual mode
wk.register({
	["<cr>"] = { "<Plug>SlimeRegionSend", "run code region" },
	["<M-j>"] = { ":m'>+<cr>`<my`>mzgv`yo`z", "move line down" },
	["<M-k>"] = { ":m'<-2<cr>`>my`<mzgv`yo`z", "move line up" },
	["."] = { ":norm .<cr>", "repat last normal mode command" },
	["q"] = { ":norm @q<cr>", "repat q macro" },
}, { mode = "v" })

wk.register({
	["<leader>"] = { "<Plug>SlimeRegionSend", "run code region" },
	p = { '"_dP', "replace without overwriting reg" },
	d = { '"_d', "delete without overwriting reg" },
}, { mode = "v", prefix = "<leader>" })

-- insert mode
wk.register({
	["<m-->"] = { " <- ", "assign" },
	["<m-m>"] = { " |>", "pipe" },
	["<m-i>"] = { insert_r_chunk, "r code chunk" },
	["<cm-i>"] = { insert_py_chunk, "python code chunk" },
	["<m-I>"] = { insert_py_chunk, "python code chunk" },
	["<c-x><c-x>"] = { "<c-x><c-o>", "omnifunc completion" },
}, { mode = "i" })
