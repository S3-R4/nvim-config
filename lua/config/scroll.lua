local M = {}
local states = {}

local function finish(win, state)
  if states[win] ~= state then return end
  states[win] = nil
  if vim.api.nvim_buf_is_valid(state.buf) then
    vim.b[state.buf].snacks_scroll = state.scroll
  end
  if vim.api.nvim_win_is_valid(win) then
    vim.wo[win].scrolloff = state.scrolloff
    if Snacks.scroll.enabled then Snacks.scroll.check(win) end
  end
end

function M.mouse(win, direction)
  if not vim.api.nvim_win_is_valid(win) then return end
  local buf = vim.api.nvim_win_get_buf(win)
  local state = states[win]
  if state and state.buf ~= buf then finish(win, state); state = nil end
  if not state then
    -- Consume Snacks' wheel event and stop any preceding keyboard animation.
    if Snacks.scroll.enabled then Snacks.scroll.check(win) end
    state = {
      buf = buf, value = 0, target = 0,
      scroll = vim.b[buf].snacks_scroll, scrolloff = vim.wo[win].scrolloff,
    }
    states[win] = state
    -- Avoid running the keyboard animator over this wheel animation.
    vim.b[buf].snacks_scroll = false
    if Snacks.scroll.enabled then Snacks.scroll.check(win) end
    vim.wo[win].scrolloff = 0
  end
  local count = tonumber(vim.o.mousescroll:match("ver:(%d+)")) or 3
  state.target = state.target + direction * count
  Snacks.animate(state.value, state.target, function(value, ctx)
    if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
      finish(win, state)
      return
    end
    local delta = value - state.value
    state.value = value
    if delta ~= 0 then
      local key = vim.api.nvim_replace_termcodes(delta > 0 and "<C-e>" or "<C-y>", true, false, true)
      vim.api.nvim_win_call(win, function()
        vim.cmd.normal({ args = { tostring(math.abs(delta)) .. key }, bang = true })
      end)
      Snacks.util.redraw(win)
    end
    if ctx.done then finish(win, state) end
  end, {
    id = "user_mouse_scroll_" .. win, int = true, easing = "linear",
    duration = { step = 45, total = 220 },
  })
end

function M.key(direction)
  local key = direction > 0 and "<ScrollWheelDown>" or "<ScrollWheelUp>"
  local win = vim.fn.getmousepos().winid
  if win == 0 or not vim.api.nvim_win_is_valid(win) then win = vim.api.nvim_get_current_win() end
  local buf = vim.api.nvim_win_get_buf(win)
  if not Snacks.scroll.enabled or vim.bo[buf].buftype ~= ""
    or vim.g.snacks_scroll == false
    or not Snacks.animate.enabled({ buf = buf, name = "scroll" })
    or (vim.b[buf].snacks_scroll == false and not states[win]) then
    return key
  end
  vim.schedule(function() M.mouse(win, direction) end)
  return ""
end

return M
