local M = {}
local api = vim.api
local palette = api.nvim_create_namespace("UserZenPalette")
local provider = api.nvim_create_namespace("UserZenScope")
local active, listener, range

local function soften(color, background)
  local result = 0
  for _, shift in ipairs({ 16, 8, 0 }) do
    local channel = math.floor(color / 2 ^ shift) % 256
    local base = math.floor(background / 2 ^ shift) % 256
    result = result + math.floor(channel * 0.82 + base * 0.18 + 0.5) * 2 ^ shift
  end
  return result
end

local function refresh_palette()
  local definitions = api.nvim_get_hl(0, {})
  local normal = api.nvim_get_hl(0, { name = "Normal", link = false })
  local background = normal.bg or 0x1f1f28
  for name in pairs(definitions) do
    local hl = api.nvim_get_hl(0, { name = name, link = false })
    hl.link = nil
    if hl.fg then hl.fg = soften(hl.fg, background) end
    api.nvim_set_hl(palette, name, hl)
  end
  -- Switching namespaces mid-row must not change the window's base color.
  -- Paint the focus background explicitly on its own rows instead.
  local floating = vim.deepcopy(normal)
  if floating.fg then floating.fg = soften(floating.fg, background) end
  api.nvim_set_hl(palette, "NormalFloat", floating)
  local unfocused = (definitions.NormalFloat or {}).bg
    or soften(background, 0)
  api.nvim_set_hl(0, "UserZenFocus", { bg = background })
  api.nvim_set_hl(0, "UserZenOutside", { bg = unfocused })
  api.nvim_set_hl(palette, "UserZenFocus", { bg = background })
  api.nvim_set_hl(palette, "UserZenOutside", { bg = unfocused })
end

function M.close()
  active, range = nil, nil
  if listener and listener.enabled then listener:disable() end
  listener = nil
  api.nvim_set_decoration_provider(provider, {})
  vim.cmd.redraw()
end

function M.open(win)
  M.close()
  active = win.win
  refresh_palette()
  api.nvim_set_decoration_provider(provider, {
    on_win = function(_, window, buf, top, bottom)
      if window ~= active then return false end
      for row = top, math.min(bottom, api.nvim_buf_line_count(buf) - 1) do
        local inside = not range or (row + 1 >= range.from and row + 1 <= range.to)
        api.nvim_buf_set_extmark(buf, provider, row, 0, {
          ephemeral = true,
          end_row = row + 1,
          end_col = 0,
          hl_group = inside and "UserZenFocus" or "UserZenOutside",
          hl_eol = true,
          priority = 50,
        })
      end
      return true
    end,
    on_line = function(_, _, _, row)
      local inside = not range or (row + 1 >= range.from and row + 1 <= range.to)
      api.nvim_set_hl_ns_fast(inside and 0 or palette)
    end,
    on_end = function() api.nvim_set_hl_ns_fast(0) end,
  })
  listener = Snacks.scope.attach(function(window, buf, scope)
    if window ~= active then return end
    if not scope then range = nil; return end
    local target = { from = scope.from, to = scope.to }
    if scope.node then
      local _, _, end_row, end_col = scope.node:range()
      if end_col == 0 and target.to == end_row + 1 then target.to = end_row end
    end
    while target.to > target.from do
      local line = api.nvim_buf_get_lines(buf, target.to - 1, target.to, false)[1]
      if not line or line:find("%S") then break end
      target.to = target.to - 1
    end
    if not range then
      local view = vim.fn.getwininfo(window)[1]
      range = { from = view.topline, to = view.botline }
    end
    for _, edge in ipairs({ "from", "to" }) do
      Snacks.animate(range[edge], target[edge], function(value)
        if active == window and range then
          range[edge] = value
          Snacks.util.redraw(window)
        end
      end, {
        int = true, id = "user_zen_" .. edge, easing = "outQuad",
        duration = { step = 20, total = 200 },
      })
    end
  end, { min_size = 5, max_size = 20, siblings = true })
end

api.nvim_create_autocmd("ColorScheme", {
  group = api.nvim_create_augroup("UserZenPalette", { clear = true }),
  callback = function() if active then refresh_palette() end end,
})

return M
