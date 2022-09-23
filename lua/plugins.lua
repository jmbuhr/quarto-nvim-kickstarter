--  bootstrap packer
local fn = vim.fn

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
    return false
end

local packer_bootstrap = ensure_packer()

-- install packages when this file is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

-- This file can be loaded by calling `lua require
require('packer').startup {
  function(use)
    -- packer can manager itself
    use 'wbthomason/packer.nvim'

    -- quarto
    use 'quarto-dev/quarto-nvim'

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

    -- show keybinding help window
    use { 'folke/which-key.nvim' }

    -- filetree
    use { 'kyazdani42/nvim-tree.lua',
      config = function()
        require 'nvim-tree'.setup {}
      end
    }

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

    -- colorschemes with TS support,
    -- so it highlights embedded languages in qmd files
    use { 'shaunsingh/nord.nvim' }
    use { "catppuccin/nvim", as = "catppuccin" }

    -- send code from python/r/qmd docuemts to the terminal
    -- thanks to tmux can be used for any repl
    -- like ipython, R, bash
    use { 'jpalardy/vim-slime',
      config = function()
        vim.g.slime_target = "tmux"
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_default_config = { socket_name = "default", target_pane = ":.2" }
        vim.b.slime_cell_delimiter = "#%%"
      end
    }


    -- lsp and treesitter
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'

    -- lsp installer
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }


    -- debug adapter protocol
    use { 'mfussenegger/nvim-dap' }
    use { 'rcarriga/nvim-dap-ui',
      config = function()
        require("dapui").setup()
      end
    }
    use {'mfussenegger/nvim-dap-python'}

    -- completion
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-calc' }
    use { 'hrsh7th/cmp-emoji' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'f3fora/cmp-spell' }
    use { 'ray-x/cmp-treesitter' }
    use { 'kdheepak/cmp-latex-symbols' }
    use { 'jc-doyle/cmp-pandoc-references' }
    use { 'L3MON4D3/LuaSnip' }
    use { 'rafamadriz/friendly-snippets' }
    use { 'windwp/nvim-autopairs', -- complete parentheses etc.
      config = function()
        require('nvim-autopairs').setup {}
      end
    }

    -- editing tools
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-surround' }

    -- color html colors
    use { 'norcalli/nvim-colorizer.lua',
      config = function()
        require 'colorizer'.setup {
          css = { css_fn = true, css = true },
          'javascript',
          'html',
          'r',
          'rmd',
          'qmd',
          'markdown',
          'python'
        }
      end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end

  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
}

return packer_bootstrap
