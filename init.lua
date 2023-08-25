require 'config.global'
require 'config.lazy'
require 'config.autocommands'
require 'config.keymap'
require 'config.color'

vim.filetype.add{
    extension = {
      webr = 'r',
    }
}

otter = require'otter'

