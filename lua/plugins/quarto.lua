return {
  { 'quarto-dev/quarto-nvim',
    version = nil,
    branch = 'quarto-ft',
    dependencies = {
      { 'jmbuhr/otter.nvim', },
      { 'quarto-dev/quarto-vim',
        dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
      },
      'neovim/nvim-lspconfig'
    },
    config = function()
      vim.g['pandoc#syntax#conceal#use'] = true
      vim.g['pandoc#syntax#codeblocks#embeds#use'] = false
      vim.g['pandoc#syntax#conceal#blacklist'] = { 'codeblock_delim', 'codeblock_start' }
      -- a=accents/ligatures d=delimiters m=math symbols  g=Greek  s=superscripts/subscripts
      vim.g['tex_conceal'] = 'g'
      require 'quarto'.setup {
        lspFeatures = {
          enabled = true,
          languages = { 'r', 'python', 'julia' },
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
