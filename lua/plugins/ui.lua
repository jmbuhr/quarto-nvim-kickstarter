return {
  -- telescope
  -- a nice seletion UI also to find and open files
  { 'nvim-telescope/telescope.nvim', config = function()
    local telescope = require 'telescope'
    local actions = require('telescope.actions')
    local previewers = require("telescope.previewers")
    local new_maker = function(filepath, bufnr, opts)
      opts = opts or {}
      filepath = vim.fn.expand(filepath)
      vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 then
          return
        else
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
      end)
    end
    telescope.setup {
      defaults = {
        buffer_previewer_maker = new_maker,
        file_ignore_patterns = { "node_modules", "%_files/*.html", "%_cache", ".git/", "site_libs" },
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
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--no-ignore", "--files", "--hidden", "--glob", "!.git/*",
            '--glob', '!**/.Rproj.user/*', '-L' },
        }
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      }
    }
    telescope.load_extension('ui-select')
    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.load_extension('file_browser')
    telescope.load_extension('project')
  end
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- { 'nvim-telescope/telescope-dap.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-telescope/telescope-project.nvim' },
  { 'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'f-person/git-blame.nvim' },
    },
    config = function()
      local git_blame = require('gitblame')
      require('lualine').setup {
        options = {
          section_separators = '',
          component_separators = '',
          globalstatus = true,
          theme = "catppuccin",
        },
        sections = {
          lualine_c = {
            { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
          }
        },
        extensions = { 'nvim-tree' },
      }
    end
  },
  { 'nanozuki/tabby.nvim', config = function()
    require 'tabby.tabline'.use_preset('tab_only')
  end
  },
  { 'dstein64/nvim-scrollview', config = function()
    require('scrollview').setup({
      current_only = true,
    })
  end
  },
  -- { 'RRethy/vim-illuminate' }, -- highlight current word
  -- filetree
  { 'kyazdani42/nvim-tree.lua',
    config = function()
      require 'nvim-tree'.setup {
        disable_netrw       = true,
        open_on_setup       = false,
        update_focused_file = {
          enable = true,
        },
        git                 = {
          enable = true,
          ignore = false,
          timeout = 500,
        },
        diagnostics         = {
          enable = true,
        },
      }
    end
  },
  -- show keybinding help window
  { 'folke/which-key.nvim' },
  { 'simrat39/symbols-outline.nvim', config = function()
    require("symbols-outline").setup()
  end },
  -- terminal
  { "akinsho/toggleterm.nvim", version = '*', config = function()
    require("toggleterm").setup {
      open_mapping = [[<c-\>]],
      direction = 'float',
    }
  end
  },
  -- show diagnostics list
  { "folke/trouble.nvim", config = function()
    require("trouble").setup {}
  end
  },
  { 'lukas-reineke/indent-blankline.nvim', config = function()
    require("indent_blankline").setup {
      show_current_context = true,
      show_current_context_start = false,
    }
  end
  },
}
