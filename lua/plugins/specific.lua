-- plugins for specifc usecases that
-- not everyone will need

return {

  -- {
  --   "jakewvincent/mkdnflow.nvim",
  --   config = function ()
  --     local mkdnflow = require("mkdnflow")
  --     mkdnflow.setup{}
  --   end
  -- },
  {
    "epwalsh/obsidian.nvim",
		-- n = { "<cmd>ObsidianQuickSwitch<cr>", "notes" },
    ft = "markdown",
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand"~/notes/**/*.md",
      "BufNewFile " .. vim.fn.expand"~/notes/**/*.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/notes",
        },
      },
    },
  }
}
