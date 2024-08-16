-- Custom handlers for LSP actions
-- using telescope.nvim
-- TODO: Some of theses don't work reliably
-- so they are not used, yet.
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local utils = require "telescope.utils"
local ms = vim.lsp.protocol.Methods

local M = {}

---@param action telescope.lsp.list_or_jump_action
---@param items vim.lsp.util.locations_to_items.ret[]
---@param opts table
---@return vim.lsp.util.locations_to_items.ret[]
local apply_action_handler = function(action, items, opts)
  if action == "textDocument/references" and not opts.include_current_line then
    local lnum = vim.api.nvim_win_get_cursor(opts.winnr)[1]
    items = vim.tbl_filter(function(v)
      return not (v.filename == opts.curr_filepath and v.lnum == lnum)
    end, items)
  end

  return items
end


--- convert `item` type back to something we can pass to `vim.lsp.util.jump_to_location`
--- stopgap for pre-nvim 0.10 - after which we can simply use the `user_data`
--- field on the items in `vim.lsp.util.locations_to_items`
---@param item vim.lsp.util.locations_to_items.ret
---@param offset_encoding string|nil utf-8|utf-16|utf-32
---@return lsp.Location
local function item_to_location(item, offset_encoding)
  local line = item.lnum - 1
  local character = vim.lsp.util._str_utfindex_enc(item.text, item.col, offset_encoding) - 1
  local uri
  if utils.is_uri(item.filename) then
    uri = item.filename
  else
    uri = vim.uri_from_fname(item.filename)
  end
  return {
    uri = uri,
    range = {
      start = {
        line = line,
        character = character,
      },
      ["end"] = {
        line = line,
        character = character,
      },
    },
  }
end

local symbols_sorter = function(symbols)
  if vim.tbl_isempty(symbols) then
    return symbols
  end

  local current_buf = vim.api.nvim_get_current_buf()

  -- sort adequately for workspace symbols
  local filename_to_bufnr = {}
  for _, symbol in ipairs(symbols) do
    if filename_to_bufnr[symbol.filename] == nil then
      filename_to_bufnr[symbol.filename] = vim.uri_to_bufnr(vim.uri_from_fname(symbol.filename))
    end
    symbol.bufnr = filename_to_bufnr[symbol.filename]
  end

  table.sort(symbols, function(a, b)
    if a.bufnr == b.bufnr then
      return a.lnum < b.lnum
    end
    if a.bufnr == current_buf then
      return true
    end
    if b.bufnr == current_buf then
      return false
    end
    return a.bufnr < b.bufnr
  end)

  return symbols
end


M.telescope_handler_factory = function(action, title)

  local opts = {
    winnr = vim.api.nvim_get_current_win()
  }

  if action == ms.textDocument_documentSymbol then
    return function(err, result, _, _)
      if err then
        vim.api.nvim_err_writeln("Error when finding document symbols: " .. err.message)
        return
      end

      if not result or vim.tbl_isempty(result) then
        utils.notify("builtin.lsp_document_symbols", {
          msg = "No results from textDocument/documentSymbol",
          level = "INFO",
        })
        return
      end

      local locations = vim.lsp.util.symbols_to_items(result or {}, opts.bufnr) or {}
      locations = utils.filter_symbols(locations, opts, symbols_sorter)
      if locations == nil then
        -- error message already printed in `utils.filter_symbols`
        return
      end

      if vim.tbl_isempty(locations) then
        utils.notify("builtin.lsp_document_symbols", {
          msg = "No document_symbol locations found",
          level = "INFO",
        })
        return
      end

      opts.path_display = { "hidden" }
      pickers
          .new(opts, {
            prompt_title = "LSP Document Symbols",
            finder = finders.new_table {
              results = locations,
              entry_maker = opts.entry_maker or make_entry.gen_from_lsp_symbols(opts),
            },
            previewer = conf.qflist_previewer(opts),
            sorter = conf.prefilter_sorter {
              tag = "symbol_type",
              sorter = conf.generic_sorter(opts),
            },
            push_cursor_on_edit = true,
            push_tagstack_on_edit = true,
          })
          :find()
    end
  else
    return function(err, result, ctx, _)
      if err then
        vim.api.nvim_err_writeln("Error when executing " .. action .. " : " .. err.message)
        return
      end

      if result == nil then
        return
      end
      local locations = {}
      if not utils.islist(result) then
        locations = { result }
      end
      vim.list_extend(locations, result)

      local offset_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
      local items = vim.lsp.util.locations_to_items(locations, offset_encoding)
      items = apply_action_handler(action, items, opts)

      if vim.tbl_isempty(items) then
        utils.notify(title, {
          msg = string.format("No %s found", title),
          level = "INFO",
        })
        return
      end

      if #items == 1 and opts.jump_type ~= "never" then
        local item = items[1]
        if opts.curr_filepath ~= item.filename then
          local cmd
          if opts.jump_type == "tab" then
            cmd = "tabedit"
          elseif opts.jump_type == "split" then
            cmd = "new"
          elseif opts.jump_type == "vsplit" then
            cmd = "vnew"
          elseif opts.jump_type == "tab drop" then
            cmd = "tab drop"
          end

          if cmd then
            vim.cmd(string.format("%s %s", cmd, item.filename))
          end
        end

        local location = item_to_location(item, offset_encoding)
        vim.lsp.util.jump_to_location(location, offset_encoding, opts.reuse_win)
      else
        pickers
            .new(opts, {
              prompt_title = title,
              finder = finders.new_table {
                results = items,
                entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
              },
              previewer = conf.qflist_previewer(opts),
              sorter = conf.generic_sorter(opts),
              push_cursor_on_edit = true,
              push_tagstack_on_edit = true,
            })
            :find()
      end
    end
  end
end


return M
