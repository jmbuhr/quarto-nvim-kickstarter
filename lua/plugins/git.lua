return {
  -- git and projects
  -- { 'ThePrimeagen/git-worktree.nvim' },
  -- { 'sindrets/diffview.nvim' },
  { 'TimUntersberger/neogit',
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
  -- github PRs and the like with gh-cli
  -- { 'pwntester/octo.nvim', config = function()
  --   require "octo".setup()
  -- end },
}
