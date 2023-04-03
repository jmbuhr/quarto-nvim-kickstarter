return {
  { 'quarto-dev/quarto-nvim',
    dev = false,
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
      { 'neovim/nvim-lspconfig' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'jmbuhr/otter.nvim',
        tag = nil,
        branch = 'nightly-treesitter',
        config = function()
          require 'otter.config'.setup {
            lsp = {
              hover = {
                border = require 'misc.style'.border
              }
            }
          }
        end,
      },
      { 'quarto-dev/quarto-vim',
        ft = 'quarto',
        dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
        -- note: needs additional vim highlighting enabled
        -- for markdown in treesitter.lua
      },
    },
    config = function()

      -- conceal can be tricky because both
      -- the treesitter highlighting and the
      -- regex vim syntax files can define conceals
      --
      -- conceallevel
      -- 0		Text is shown normally
      -- 1		Each block of concealed text is replaced with one
      -- 		character.  If the syntax item does not have a custom
      -- 		replacement character defined (see |:syn-cchar|) the
      -- 		character defined in 'listchars' is used.
      -- 		It is highlighted with the "Conceal" highlight group.
      -- 2		Concealed text is completely hidden unless it has a
      -- 		custom replacement character defined (see
      -- 		|:syn-cchar|).
      -- 3		Concealed text is completely hidden.
      vim.opt.conceallevel = 1

      -- disable conceal in markdown/quarto
      vim.g['pandoc#syntax#conceal#use'] = false

      -- embeds are already handled by treesitter injectons
      vim.g['pandoc#syntax#codeblocks#embeds#use'] = false

      vim.g['pandoc#syntax#conceal#blacklist'] = { 'codeblock_delim', 'codeblock_start' }

      -- but allow some types of conceal in math reagions:
      -- a=accents/ligatures d=delimiters m=math symbols
      -- g=Greek  s=superscripts/subscripts
      vim.g['tex_conceal'] = 'gm'

      require 'quarto'.setup {
        lspFeatures = {
          enabled = true,
          languages = { 'r', 'python', 'julia', 'bash' },
          chunks = 'curly', -- 'curly' or 'all'
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
  { 'jpalardy/vim-slime',
    init = function()

      Quarto_is_in_python_chunk = function()
        vim.b.quarto_is_python_chunk = false
        local ts = vim.treesitter
        local language_tree = ts.get_parser(0, 'markdown')
        local syntax_tree = language_tree:parse()
        local root = syntax_tree[1]:root()

        -- create capture
        local query = vim.treesitter.query.parse('markdown', require 'otter.tools.queries'['markdown'])

        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        row = row - 1
        col = col

        -- get text ranges
        for pattern, match, metadata in query:iter_matches(root, 0) do
          -- each match has two nodes, the language and the code
          -- the language node is the first one
          local found = false -- reset found for the next match
          for id, node in pairs(match) do
            local name = query.captures[id]
            local ok, text = pcall(vim.treesitter.get_node_text, node, 0)
            if not ok then return false end
            if name == 'lang' and text == 'python' then
              -- we found a match where the language node matches
              -- the otter language
              found = true
            end
            -- the corresponding code is in the current range
            if found and name == 'code' and ts.is_in_node_range(node, row, col) then
              vim.b.quarto_is_python_chunk = true
            end
          end
        end
      end

      vim.cmd [[
      function SlimeOverride_EscapeText_quarto(text)
        call v:lua.Quarto_is_in_python_chunk() 
        if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
          return ["%cpaste -q", "\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
        else
          return a:text
        end
      endfunction
      ]]

      vim.b.slime_cell_delimiter = "#%%"
      -- -- slime, tmux
      -- vim.g.slime_target = 'tmux'
      -- vim.g.slime_bracketed_paste = 1
      -- vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }

      -- slime, neovvim terminal
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1
    end
  },
  -- paste an image to markdown from the clipboard
  -- :PasteImg,
  'ekickx/clipboard-image.nvim',

  -- display images in the terminal!
  { 'edluffy/hologram.nvim',
    config = function()
      -- require'hologram'.setup{
      --   auto_display = true
      -- }
    end
  },
}
