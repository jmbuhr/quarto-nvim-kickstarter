local api = require 'image'

M = {}

local function get_image_at_cursor(buf)
  local images = api.get_images { buffer = buf }
  local row = vim.api.nvim_win_get_cursor(0)[1]
  for _, img in ipairs(images) do
    if img.geometry ~= nil and img.geometry.y == row then
      return img
    end
  end
  return nil
end

M.main = function()
  local cur_buf = vim.api.nvim_get_current_buf()
  local image = get_image_at_cursor(cur_buf)
  if image == nil then
    return
  end

  local width = vim.api.nvim_get_option_value('columns', {})
  local height = vim.api.nvim_get_option_value('lines', {})

  local preview_buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(preview_buf, true, {
    relative = 'editor',
    anchor = 'NW',
    width = width,
    height = height,
    row = 0,
    col = 0,
    zindex = 300,
    style = 'minimal',
  })

  -- copy original options to reset afterwards
  local og_options = {}
  for k, v in pairs(image.global_state.options) do
    og_options[k] = v
  end

  local og_extmark = image.extmark

  image.global_state.options.max_height = nil
  image.global_state.options.max_width = nil
  image.global_state.options.max_width_window_percentage = nil
  image.global_state.options.max_height_window_percentage = nil

  for _, img in ipairs(api.get_images()) do
    img:clear()
  end

  vim.print(image.global_state)

  api.hijack_buffer(image.path, win, preview_buf)

  vim.keymap.set('n', 'q', function()
    api.clear()
    image.global_state.options = og_options
    image.extmark = og_extmark
    image:render()
    vim.api.nvim_win_close(win, true)
  end, { buffer = preview_buf })
end

vim.keymap.set('n', '<leader>io', M.main, { desc = '[i]mage [o]pen' })
