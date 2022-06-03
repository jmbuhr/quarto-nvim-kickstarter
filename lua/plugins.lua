--  bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd[[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

-- This file can be loaded by calling `lua require
return require('packer').startup(function(use)
	-- packer can manager itself
	use 'wbthomason/packer.nvim'

	-- quarto
  use 'jmbuhr/quarto-nvim'

	-- common dependencies
	use { 'ryanoasis/vim-devicons' }
	use { 'kyazdani42/nvim-web-devicons' }
	use { 'nvim-lua/plenary.nvim' }

	-- telescope
	-- a nice seletion UI also to find and open files
	use { 'nvim-telescope/telescope.nvim' }
	use { 'nvim-telescope/telescope-ui-select.nvim' }
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use { 'nvim-telescope/telescope-packer.nvim' }

	-- filetree
	use { 'kyazdani42/nvim-tree.lua' }


	-- paste an image to markdown from the clipboard
	-- use :PasteImg
	use 'ekickx/clipboard-image.nvim'

	-- commenting with e.g. `gcc` or `gcip`
	-- respects TS, so it works in quarto documents
	use { 'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup {}
		end
	}


	-- colorscheme with TS support,
	-- so it highlights embedded languages in qmd files
	use 'shaunsingh/nord.nvim' 

	-- send code from python/r/qmd docuemts to the terminal
	-- thanks to tmux can be used for any repl
	-- like ipython, R, bash
	use { 'jpalardy/vim-slime',
		config = function()
			vim.g.slime_target = "tmux"
			vim.g.slime_python_ipython = 1
			vim.g.slime_default_config = { socket_name = "default", target_pane = ":.2" }
			vim.b.slime_cell_delimiter = "#%%"
		end
	}


	-- lsp and treesitter
	use 'neovim/nvim-lspconfig'
	use 'onsails/lspkind-nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-treesitter/nvim-treesitter-textobjects' }


	-- completion
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-calc' }
	use { 'hrsh7th/cmp-emoji' }
	use { 'saadparwaiz1/cmp_luasnip' }
	use { 'hrsh7th/cmp-nvim-lua' }
	use { 'f3fora/cmp-spell' }
	use { 'ray-x/cmp-treesitter' }
	use { 'kdheepak/cmp-latex-symbols' }
	use { 'jc-doyle/cmp-pandoc-references' }
	use { 'L3MON4D3/LuaSnip' }
	use { 'rafamadriz/friendly-snippets' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
end)


