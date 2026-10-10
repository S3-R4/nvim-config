local M = {}

function M.toggle()
  local windows = vim.api.nvim_tabpage_list_wins(0)
  for _, win in ipairs(windows) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "floggraph" then
      if #windows > 1 then
        vim.api.nvim_win_close(win, false)
      else
        local alternate = vim.fn.bufnr("#")
        if alternate > 0 and vim.api.nvim_buf_is_valid(alternate)
          and vim.bo[alternate].filetype ~= "floggraph" then
          vim.api.nvim_win_set_buf(win, alternate)
        else
          vim.api.nvim_win_set_buf(win, vim.api.nvim_create_buf(true, false))
        end
      end
      return
    end
  end

  vim.cmd("Flog")
  if vim.bo.filetype ~= "floggraph" then return end
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(win, math.max(24, math.min(52, math.floor(vim.o.columns * 0.35))))
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].wrap = false
  vim.wo[win].winfixwidth = true
end

return M
