local M = {}

local function darken(color, amount)
  if type(color) ~= "string" or not color:match("^#%x%x%x%x%x%x$") then return color end
  local rgb = {}
  for i = 1, 3 do
    rgb[i] = math.floor(tonumber(color:sub(i * 2, i * 2 + 1), 16) * amount)
  end
  return ("#%02x%02x%02x"):format(unpack(rgb))
end

function M.theme()
  local theme = vim.deepcopy(require("lualine.utils.loader").load_theme("auto"))
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local background = normal.bg and ("#%06x"):format(normal.bg) or "#1f1f28"
  for _, sections in pairs(theme) do
    for section, colors in pairs(sections) do
      if type(colors) == "table" then
        if section == "c" then
          colors.bg = darken(background, 0.65)
        elseif section == "b" then
          colors.bg = darken(background, 0.82)
        else
          colors.bg = darken(colors.bg, 0.85)
        end
      end
    end
  end
  return theme
end

return M
