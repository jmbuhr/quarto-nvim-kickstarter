return {

  { 'quarto-dev/quarto-nvim',
    dev = true,
    dependencies = {
      { 'jmbuhr/otter.nvim',
        dev = true,
      },
      'neovim/nvim-lspconfig'
    },
    config = function()
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

  -- common dependencies
  { 'ryanoasis/vim-devicons' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'nvim-lua/plenary.nvim' },

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
    telescope.load_extension("git_worktree")

  end
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope-packer.nvim' },
  { 'nvim-telescope/telescope-dap.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-telescope/telescope-project.nvim' },


  -- show keybinding help window
  { 'folke/which-key.nvim' },

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

  -- paste an image to markdown from the clipboard
  -- :PasteImg,
  'ekickx/clipboard-image.nvim',

  -- commenting with e.g. `gcc` or `gcip`
  -- respects TS, so it works in quarto documents
  { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup {}
  end
  },

  -- colorschemes with TS support,
  -- so it highlights embedded languages in qmd files
  { 'shaunsingh/nord.nvim' },
  { 'folke/tokyonight.nvim' },
  { "catppuccin/nvim", name = "catppuccin", config = function()
    require("catppuccin").setup {
      flavour = "mocha", -- mocha, macchiato, frappe, latte
      term_colors = true,
      integrations = {
        nvimtree = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true
      }
    }
  end
  },
  { 'EdenEast/nightfox.nvim' },

  -- send code from python/r/qmd docuemts to the terminal
  -- thanks to tmux can be used for any repl
  -- like ipython, R, bash
  { 'jpalardy/vim-slime' },

  -- lsp and treesitter
  'neovim/nvim-lspconfig',
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/playground',

  { 'folke/neoconf.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require("neoconf").setup({
      })
    end
  },

  -- lsp installer
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  { 'simrat39/symbols-outline.nvim', config = function()
    require("symbols-outline").setup()

  end },

  -- show diagnostics list
  { "folke/trouble.nvim", config = function()
    require("trouble").setup {}
  end
  },

  -- completion
  { 'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-emoji' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'f3fora/cmp-spell' },
      { 'ray-x/cmp-treesitter' },
      { 'kdheepak/cmp-latex-symbols' },
      { 'jc-doyle/cmp-pandoc-references' },
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
      { 'onsails/lspkind-nvim' },
      { "KadoBOT/cmp-plugins",
        config = function()
          require("cmp-plugins").setup({
            files = { "plugins.lua" } -- Recommended: use static filenames or partial paths
          })
        end,
      },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require "lspkind"
      lspkind.init()

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-f>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-n>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
              fallback()
            end
          end, { "i", "s" }),
          ['<C-p>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<c-a>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        autocomplete = false,
        formatting = {
          format = lspkind.cmp_format {
            with_text = true,
            menu = {
              luasnip = "[snip]",
              nvim_lsp = "[LSP]",
              buffer = "[buf]",
              path = "[path]",
              spell = "[spell]",
              pandoc_references = "[ref]",
              tags = "[tag]",
              treesitter = "[TS]",
              calc = "[calc]",
              latex_symbols = "[tex]",
              emoji = "[emoji]",
              otter = "[🦦]",
            },
          },
        },
        sources = {
          { name = 'path' },
          { name = 'plugins' },
          { name = 'nvim_lsp' },
          { name = 'luasnip', keyword_length = 3, max_item_count = 3 },
          { name = 'pandoc_references' },
          { name = 'buffer', keyword_length = 5, max_item_count = 3 },
          { name = 'spell' },
          { name = 'treesitter', keyword_length = 5, max_item_count = 3 },
          { name = 'calc' },
          { name = 'latex_symbols' },
          { name = 'emoji' },
          { name = 'otter' },
        },
        view = {
          entries = "native",
        },
        window = {
          documentation = {
            border = require 'misc.style'.border,
          },
        },
      })

      -- for friendly snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      -- for custom snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snips" } })

    end
  },

  { 'windwp/nvim-autopairs', config = function()
    require('nvim-autopairs').setup {}
  end
  },

  -- editing tools
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },

  { 'lukas-reineke/indent-blankline.nvim', config = function()
    require("indent_blankline").setup {
      show_current_context = true,
      show_current_context_start = false,
    }
  end
  },

  -- enhanced f t motions
  { 'ggandor/flit.nvim',
    dependencies = { 'ggandor/leap.nvim' },
    config = function()
      require('flit').setup {
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        labeled_modes = "v",
        multiline = true,
        opts = {}
      }
    end
  },


  -- color html colors
  { 'norcalli/nvim-colorizer.lua', config = function()
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
  },

  --custom
  -- git and projects
  { 'ThePrimeagen/git-worktree.nvim' },
  { 'sindrets/diffview.nvim' },
  { 'TimUntersberger/neogit', config = function()
    require('neogit').setup {
      disable_commit_confirmation = true,
      integrations = {
        diffview = true
      }
    }
  end
  },
  { 'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup {}
  end
  },
  { 'akinsho/git-conflict.nvim', config = function()
    require('git-conflict').setup {
      default_mappings = true,
      disable_diagnostics = true,
    }
  end
  },

  { 'f-person/git-blame.nvim' },
  { 'nvim-lualine/lualine.nvim', config = function()
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

  -- terminal
  { "akinsho/toggleterm.nvim", version = '*', config = function()
    require("toggleterm").setup {
      open_mapping = [[<c-\>]],
      direction = 'float',
    }
  end
  },
}
