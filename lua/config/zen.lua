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
  local normal = api.nvim_get_hl(0, { name = "Normal", link = false })
  local background = normal.bg or 0x1f1f28
  for name, hl in pairs(api.nvim_get_hl(0, { link = false })) do
    if hl.fg then hl.fg = soften(hl.fg, background) end
    api.nvim_set_hl(palette, name, hl)
  end
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
    on_win = function(_, window)
      return window == active
    end,
    on_line = function(_, _, _, row)
      local inside = not range or (row + 1 >= range.from and row + 1 <= range.to)
      api.nvim_set_hl_ns_fast(inside and 0 or palette)
    end,
    on_end = function() api.nvim_set_hl_ns_fast(0) end,
  })
  listener = Snacks.scope.attach(function(window, _, scope)
    if window ~= active then return end
    if not scope then range = nil; return end
    if not range then
      local view = vim.fn.getwininfo(window)[1]
      range = { from = view.topline, to = view.botline }
    end
    for _, edge in ipairs({ "from", "to" }) do
      Snacks.animate(range[edge], scope[edge], function(value)
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
