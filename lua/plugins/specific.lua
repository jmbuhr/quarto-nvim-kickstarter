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
    ft = "markdown",
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand "~/notes/**/*.md",
      "BufNewFile " .. vim.fn.expand "~/notes/**/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>nd", ':ObsidianToday<cr>',       "obsidian daily" },
      { "<leader>nt", ':ObsidianTomorrow<cr>',    "obsidian tomorrow" },
      { "<leader>ny", ':ObsidianYesterday<cr>',   "obsidian yesterday" },
      { "<leader>nb", ':ObsidianBacklinks<cr>',   "obsidian backlinks" },
      { "<leader>nl", ':ObsidianLink<cr>',        "obsidian link selection" },
      { "<leader>nf", ':ObsidianFollowLink<cr>',  "obsidian follow link" },
      { "<leader>nn", ':ObsidianNew<cr>',         "obsidian new" },
      { "<leader>ns", ':ObsidianSearch<cr>',      "obsidian search" },
      { "<leader>no", ':ObsidianQuickSwitch<cr>', "obsidian quickswitch" },
    },
    config = function()
      require("obsidian").setup {
        workspaces = {
          {
            name = "notes",
            path = "~/notes",
          },
        },
        mappings = {
          -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          -- create and toggle checkboxes
          ["<cr>"] = {
            action = function()
              local line = vim.api.nvim_get_current_line()
              if line:match("%s*- %[") then
                require("obsidian").util.toggle_checkbox()
              elseif line:match("%s*-") then
                vim.cmd [[s/-/- [ ]/]]
                vim.cmd.nohlsearch()
              end
            end,
            opts = { buffer = true },
          },
        },
      }

    vim.wo.conceallevel = 1

    end,
  }
}
