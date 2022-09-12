
-- LSP
local lspconfig = require('lspconfig')
local cmp = require('cmp_nvim_lsp')
local configs = require 'lspconfig.configs'
local util = require("lspconfig.util")

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "pyright", "r_language_server", "emmet_ls",
    "cssls", "diagnosticls", "debugpy" }
})

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  client.resolved_capabilities.document_formatting = true
end

local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.r_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 250,
  }
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 250,
  },
  root_dir = function(fname)
    return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
        util.path.dirname(fname)
  end
}

lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  init_options = {
    formatters = {
      black = {
        command = "black",
        args = { "--quiet", "-" },
        rootPatterns = { ".git", "pyproject.toml", "setup.py", "tox." },
      },
      formatFiletypes = {
        python = { "black" }
      }
    }
  }
}


if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = { 'emmet-ls', '--stdio' };
      filetypes = { 'html', 'css', 'blade', 'jsx', 'xml', 'scss' };
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end
lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}


lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim', 'quarto', 'pandoc', 'io', 'string' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

