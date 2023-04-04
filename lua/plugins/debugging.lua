return {
  { "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-python" },
    config = function()
      require("neotest").setup {
        adapters = {
          require("neotest-python")
        }
      }
    end,
    keys = {
      { "<leader>dtt", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>", desc = "test" },
      { "<leader>dts", ":lua require'neotest'.run.stop()<cr>", desc = "stop test" },
      { "<leader>dta", ":lua require'neotest'.run.attach()<cr>", desc = "attach test" },
      { "<leader>dtf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "test file" },
      { "<leader>dts", ":lua require'neotest'.summary.toggle()<cr>", desc = "test summary" },
    }
  },

  -- debug adapter protocol
  { 'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui',
        config = function()
          vim.fn.sign_define('DapBreakpoint', { text = '🦦', texthl = '', linehl = '', numhl = '' })
          require("dapui").setup()
        end
      },
      { 'mfussenegger/nvim-dap-python',
        config = function()
          require('dap-python').setup()
          require('dap.ext.vscode').load_launchjs('launch.json')
        end
      },
    },
    keys = {
      { "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", desc = "debug breakpoint" },
      { "<leader>dc", ": lua require'dap'.continue()<cr>", desc = "debug" },
      { "<leader>do", ": lua require'dap'.step_over()<cr>", desc = "debug over" },
      { "<leader>di", ": lua require'dap'.step_into()<cr>", desc = "debug into" },
      { "<leader>dr", ": lua require'dap'.repl_open()<cr>", desc = "debug repl" },
      { "<leader>du", ": lua require'dapui'.toggle()<cr>", desc = "debug into" },
    },
  },
}
