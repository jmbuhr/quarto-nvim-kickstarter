return {
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
      require('nvim-autopairs').remove_rule '`'
    end,
  },

  { -- new completion plugin
    'saghen/blink.cmp',
    enabled = true,
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      {'L3MON4D3/LuaSnip',
        config = function ()
          local luasnip = require 'luasnip'
          -- for friendly snippets
          require('luasnip.loaders.from_vscode').lazy_load()
          -- for custom snippets
          require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snips' } }
          -- link quarto and rmarkdown to markdown snippets
          luasnip.filetype_extend('quarto', { 'markdown' })
          luasnip.filetype_extend('rmarkdown', { 'markdown' })
        end
      },
      {
        'saghen/blink.compat',
        dev = false,
        opts = { impersonate_nvim_cmp = true, enable_events = true, debug = true },
      },
      {
        'jmbuhr/cmp-pandoc-references',
        dev = false,
        ft = { 'quarto', 'markdown', 'rmarkdown' },
      },
      {
        "allaman/emoji.nvim",
        opts = { enable_cmp_integration = true },
      },
      { 'kdheepak/cmp-latex-symbols' },
    },

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = { preset = 'enter' },
      snippets = {
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
      },
      sources = {
        completion = {
          enabled_providers = { "lsp", "path", "luasnip", "buffer", "lazydev", "pandoc_references", "emoji", "latex_symbols", "codecompanion", }
        },
        providers = {
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
          pandoc_references = { name = "pandoc_references", module = "blink.compat.source", opts = {impersonate_nvim_cmp = true} },
          emoji = { name = "emoji", module = "blink.compat.source", opts = {impersonate_nvim_cmp = true} },
          latex_symbols = { name = "latex_symbols", module = "blink.compat.source", opts = {impersonate_nvim_cmp = true} },
          codecompanion = { name = 'CodeCompanion', module = 'codecompanion.providers.completion.blink', enabled = true },
        },
      },

      highlight = {
        use_nvim_cmp_as_default = true,
      },
      nerd_font_variant = 'mono',
      completion = { accept = { auto_brackets = { enabled = true } } },
      signature = { enabled = true },
    }
  },

  -- { -- completion
  --   'hrsh7th/nvim-cmp',
  --   enabled = false,
  --   event = 'InsertEnter',
  --   dependencies = {
  --     'hrsh7th/cmp-nvim-lsp',
  --     'jmbuhr/cmp-nvim-lsp-signature-help',
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-path',
  --     'hrsh7th/cmp-calc',
  --     'hrsh7th/cmp-emoji',
  --     'saadparwaiz1/cmp_luasnip',
  --     'f3fora/cmp-spell',
  --     'ray-x/cmp-treesitter',
  --     'kdheepak/cmp-latex-symbols',
  --     'jmbuhr/cmp-pandoc-references',
  --     'L3MON4D3/LuaSnip',
  --     'rafamadriz/friendly-snippets',
  --     'onsails/lspkind-nvim',
  --   },
  --   config = function()
  --     local cmp = require 'cmp'
  --     local luasnip = require 'luasnip'
  --     local lspkind = require 'lspkind'
  --
  --     local has_words_before = function()
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
  --     end
  --
  --     cmp.setup {
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       completion = { completeopt = 'menu,menuone,noinsert' },
  --       mapping = {
  --         ['<C-f>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-d>'] = cmp.mapping.scroll_docs(4),
  --
  --         ['<C-n>'] = cmp.mapping(function(fallback)
  --           if luasnip.expand_or_jumpable() then
  --             luasnip.expand_or_jump()
  --             fallback()
  --           end
  --         end, { 'i', 's' }),
  --         ['<C-p>'] = cmp.mapping(function(fallback)
  --           if luasnip.jumpable(-1) then
  --             luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { 'i', 's' }),
  --         ['<C-e>'] = cmp.mapping.abort(),
  --         ['<c-y>'] = cmp.mapping.confirm {
  --           select = true,
  --         },
  --         ['<CR>'] = cmp.mapping.confirm {
  --           select = true,
  --         },
  --
  --         ['<Tab>'] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           elseif has_words_before() then
  --             cmp.complete()
  --           else
  --             fallback()
  --           end
  --         end, { 'i', 's' }),
  --         ['<S-Tab>'] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           else
  --             fallback()
  --           end
  --         end, { 'i', 's' }),
  --
  --         ['<C-l>'] = cmp.mapping(function()
  --           if luasnip.expand_or_locally_jumpable() then
  --             luasnip.expand_or_jump()
  --           end
  --         end, { 'i', 's' }),
  --         ['<C-h>'] = cmp.mapping(function()
  --           if luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           end
  --         end, { 'i', 's' }),
  --       },
  --       autocomplete = false,
  --
  --       ---@diagnostic disable-next-line: missing-fields
  --       formatting = {
  --         format = lspkind.cmp_format {
  --           mode = 'symbol',
  --           menu = {
  --             nvim_lsp = '[LSP]',
  --             nvim_lsp_signature_help = '[sig]',
  --             luasnip = '[snip]',
  --             buffer = '[buf]',
  --             path = '[path]',
  --             spell = '[spell]',
  --             pandoc_references = '[ref]',
  --             tags = '[tag]',
  --             treesitter = '[TS]',
  --             calc = '[calc]',
  --             latex_symbols = '[tex]',
  --             emoji = '[emoji]',
  --           },
  --         },
  --       },
  --       sources = {
  --         { name = 'path' },
  --         { name = 'nvim_lsp_signature_help' },
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip',                keyword_length = 3, max_item_count = 3 },
  --         { name = 'pandoc_references' },
  --         { name = 'buffer',                 keyword_length = 5, max_item_count = 3 },
  --         { name = 'spell' },
  --         { name = 'treesitter',             keyword_length = 5, max_item_count = 3 },
  --         { name = 'calc' },
  --         { name = 'latex_symbols' },
  --         { name = 'emoji' },
  --       },
  --       view = {
  --         entries = 'native',
  --       },
  --       window = {
  --         documentation = {
  --           border = require('misc.style').border,
  --         },
  --       },
  --     }
  --
  --     -- for friendly snippets
  --     require('luasnip.loaders.from_vscode').lazy_load()
  --     -- for custom snippets
  --     require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snips' } }
  --     -- link quarto and rmarkdown to markdown snippets
  --     luasnip.filetype_extend('quarto', { 'markdown' })
  --     luasnip.filetype_extend('rmarkdown', { 'markdown' })
  --   end,
  -- },
  --
  { -- gh copilot
    'zbirenbaum/copilot.lua',
    enabled = true,
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<c-a>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        panel = { enabled = false },
      }
    end,
  },

  { -- LLMs
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { '<leader>ac', ':CodeCompanionChat Toggle<cr>', desc = '[a]i [c]hat' },
      { '<leader>aa', ':CodeCompanionActions<cr>', desc = '[a]i [a]actions' },
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
          agent = {
            adapter = "copilot",
          },
        },
      })
    end
  }
}
