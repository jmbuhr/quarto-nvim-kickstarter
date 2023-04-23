local lspconfig = require("lspconfig")


local function ltex_installed()
  local register = require("mason-registry").get_installed_package_names()
  local installed = false
  for _, v in pairs(register) do
    if v == "ltex-ls" then
      installed = true
      break
    end
  end
  return installed
end



local setup = {
    filetypes = {"markdown", "latex", "rmd", "tex", "plaintex", "quarto"};
    settings = {
       ltex = {
         enabled = {"markdown", "rmd", "tex", "plaintex", "quarto"},
       }
     }
  }
if ltex_installed() then
  lspconfig.ltex.setup(setup)
end

