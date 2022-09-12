
local telescope = require'telescope'
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    file_ignore_patterns = { "node_modules", "%_files", "%_cache", ".git/", "site_libs" },
    layout_strategy = "flex",
    sorting_strategy = "ascending",
    layout_config = {
        prompt_position = "top",
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<esc>"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      }
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  }
}

telescope.load_extension('ui-select')
