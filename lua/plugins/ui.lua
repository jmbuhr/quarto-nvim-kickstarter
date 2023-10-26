return {
  -- telescope
  -- a nice seletion UI also to find and open files
  {
    'nvim-telescope/telescope.nvim',
    config = function()
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
          file_ignore_patterns = { "node_modules", "%_files/*.html", "%_cache", ".git/", "site_libs", ".venv" },
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
            hidden = false,
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*",
              '--glob', '!**/.Rproj.user/*', "--glob", "!_site/*",
              "--glob", "!docs/**/*.html",
              '-L' },
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
        }
      }
      -- telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
      telescope.load_extension('file_browser')
      telescope.load_extension('dap')
    end
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
  { 'nvim-telescope/telescope-dap.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local function macro_recording()
        local reg = vim.fn.reg_recording()
        if reg == '' then
          return ''
        end
        return '📷[' .. reg .. ']'
      end

      require('lualine').setup {
        options = {
          section_separators = '',
          component_separators = '',
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode', macro_recording },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          -- lualine_b = {},
          lualine_c = { 'searchcount' },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        extensions = { 'nvim-tree' },
      }
    end
  },

  {
    'nanozuki/tabby.nvim',
    config = function()
      require 'tabby.tabline'.use_preset('tab_only')
    end
  },

  -- {
  --   'dstein64/nvim-scrollview',
  --   config = function()
  --     require('scrollview').setup({
  --       current_only = true,
  --     })
  --   end
  -- },

  -- { 'RRethy/vim-illuminate' }, -- highlight current word

  -- filetree
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<c-b>', ':NvimTreeToggle<cr>', desc = 'toggle nvim-tree' },
    },
    config = function()
      require 'nvim-tree'.setup {
        disable_netrw       = true,
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

  {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    keys = {
      { '<leader>lo', ':SymbolsOutline<cr>', desc = 'symbols outline' },
    },
    config = function()
      require("symbols-outline").setup()
    end
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    version = '*',
    config = function()
      require("toggleterm").setup {
        open_mapping = [[<c-\>]],
        direction = 'float',
      }
    end
  },
  -- show diagnostics list
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {}
    end
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("ibl").setup {
      indent = { char = "│" }
      }
    end
  },

  {
    'lukas-reineke/headlines.nvim',
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("headlines").setup {
        quarto = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
                (fenced_code_block) @codeblock
            ]]),
          codeblock_highlight = "CodeBlock",
          treesitter_language = "markdown",
        },
      }
    end
  },


  {
    '3rd/image.nvim',
    config = function()
      if true then
        return
      end
      -- setup
      -- Example for configuring Neovim to load user-installed installed Lua rocks:
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            -- clear_in_insert_mode = true,
            -- download_remote_images = true,
            -- only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki", "quarto" },
          },
        },
        max_width = 90,
        max_height = 90,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      })
    end
  }





}
