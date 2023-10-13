return {
  -- git and projects
  { 'sindrets/diffview.nvim' },
  {
    'NeogitOrg/neogit',
    lazy = true,
    cmd = 'Neogit',
    config = function()
      require('neogit').setup {
        disable_commit_confirmation = true,
        integrations = {
          diffview = true
        }
      }
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {}
    end
  },
  {
    'akinsho/git-conflict.nvim',
    init = function()
      require('git-conflict').setup {
        default_mappings = false,
        disable_diagnostics = true,
      }
    end,
    keys = {
      { '<leader>gco', ':GitConflictChooseOurs<cr>' },
      { '<leader>gct', ':GitConflictChooseTheirs<cr>' },
      { '<leader>gcb', ':GitConflictChooseBoth<cr>' },
      { '<leader>gc0', ':GitConflictChooseNone<cr>' },
      { ']x', ':GitConflictNextConflict<cr>' },
      { '[x', ':GitConflictPrevConflict<cr>' },
    },
  },
  {
    'f-person/git-blame.nvim',
    init = function()
      vim.g.gitblame_display_virtual_text = 1
      vim.g.gitblame_enabled = 0
    end
  },
  -- github PRs and the like with gh-cli
  -- { 'pwntester/octo.nvim', config = function()
  --   require "octo".setup()
  -- end },
}
