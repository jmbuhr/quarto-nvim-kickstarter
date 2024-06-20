return {
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = { 'r', 'python', 'markdown', 'markdown_inline', 'vim' },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
  } 
  end 
}
}


