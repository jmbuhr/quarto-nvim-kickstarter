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
  { 'neovim/nvim-lspconfig',
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", config = true },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim",
        config = {
          automatic_installation = true,
        }
      },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup()

      local lspconfig = require('lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local util = require("lspconfig.util")

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true
      })

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        local opts = { noremap = true, silent = true }

        buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', opts)
        client.server_capabilities.document_formatting = true
      end


      local on_attach2 = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        local opts = { noremap = true, silent = true }

        buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
        buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', opts)
        client.server_capabilities.document_formatting = true
      end

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
        { border = require 'misc.style'.border })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
        { border = require 'misc.style'.border })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- also needs:
      -- $home/.config/marksman/config.toml :
      -- [core]
      -- markdown.file_extensions = ["md", "markdown", "qmd"]
      lspconfig.marksman.setup {
        on_attach = on_attach2,
        capabilities = capabilities,
        filetypes = { 'markdown', 'quarto' },
        root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
      }

      lspconfig.r_language_server.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags
      }

      lspconfig.emmet_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags
      }

      lspconfig.cssls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags
      }

      local function strsplit(s, delimiter)
        local result = {}
        for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
          table.insert(result, match)
        end
        return result
      end

      local function get_quarto_resource_path()
        local f = assert(io.popen('quarto --paths', 'r'))
        local s = assert(f:read('*a'))
        f:close()
        return strsplit(s, '\n')[2]
      end

      local lua_library_files = vim.api.nvim_get_runtime_file("", true)
      local resource_path = get_quarto_resource_path()
      table.insert(lua_library_files, resource_path .. '/lua-types')
      local lua_plugin_paths = {}
      table.insert(lua_plugin_paths, resource_path .. '/lua-plugin/plugin.lua')

      lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace"
            },
            runtime = {
              version = 'LuaJIT',
              plugin = lua_plugin_paths[1],
            },
            diagnostics = {
              globals = { 'vim', 'quarto', 'pandoc', 'io', 'string', 'print', 'require', 'table' },
              disable = { 'trailing-space' },
            },
            workspace = {
              library = lua_library_files,
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      lspconfig.pyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        root_dir = function(fname)
          return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
              util.path.dirname(fname)
        end
      }

      lspconfig.julials.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
      }

      lspconfig.bashls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = {'sh', 'bash'}
      }
    end
  }
}
