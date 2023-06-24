return {
  -- git and projects
  { 'sindrets/diffview.nvim' },
  {
    'TimUntersberger/neogit',
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
    config = function()
      require('git-conflict').setup {
        default_mappings = true,
        disable_diagnostics = true,
      }
    end
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
