return {
  { 'quarto-dev/quarto-nvim',
    dependencies = {
      { 'jmbuhr/otter.nvim', },
      { 'quarto-dev/quarto-vim',
        dev = false,
        dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
      },
      'neovim/nvim-lspconfig'
    },
    config = function()
      vim.cmd [[
        let g:pandoc#syntax#conceal#use=0 
        let g:pandoc#syntax#codeblocks#embeds#use=0
      ]]
      require 'quarto'.setup {
        lspFeatures = {
          enabled = true,
          languages = { 'r', 'python', 'julia', 'haskell', 'lua' },
          diagnostics = {
            enabled = true,
            triggers = { "BufWrite" }
          },
          completion = {
            enabled = true
          }
        }
      }
    end
  },
  -- send code from python/r/qmd docuemts to the terminal
  -- thanks to tmux can be used for any repl
  -- like ipython, R, bash
  { 'jpalardy/vim-slime' },
  -- paste an image to markdown from the clipboard
  -- :PasteImg,
  'ekickx/clipboard-image.nvim',
}

