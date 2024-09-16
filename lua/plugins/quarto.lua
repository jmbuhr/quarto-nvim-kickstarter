return {
  { 'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      'neovim/nvim-lspconfig'
    },
    config = function()
      require 'quarto'.setup {
        lspFeatures = {
          enabled = false,
          languages = { 'r', 'python' },
          diagnostics = {
            enabled = false,
            triggers = { "BufWrite" }
          },
          completion = {
            enabled = false
          }
        }
      }
    end
  },
  -- send code from python/r/qmd docuemts to a terminal
  -- like ipython, R, bash
  { 'jpalardy/vim-slime' },
  -- paste an image to markdown from the clipboard
  -- with :PasteImg,
  'ekickx/clipboard-image.nvim',

}
