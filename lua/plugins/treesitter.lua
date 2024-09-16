return {
  {
    'nvim-treesitter/nvim-treesitter',
    dev = false,
    ---dependencies = {
      --{
        --'nvim-treesitter/nvim-treesitter-textobjects',
      --},
    --},
    run = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        ensure_installed = {
          'r',
          'python',
          'markdown',
          'markdown_inline',
          'bash',
          'lua',
          'vim',
          'query',
          'vimdoc',
          'mermaid'
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      }
    end,
},
}
