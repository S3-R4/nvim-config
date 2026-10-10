local M = {}
function M.run(command)
  local vault = require("config.settings").notes.vault
  if vault == "" or vim.fn.isdirectory(vim.fn.expand(vault)) == 0 then
    vim.notify("Set notes.vault with :ConfigLocal (or NVIM_NOTES_VAULT), then restart Neovim.", vim.log.levels.WARN)
    return
  end
  vim.cmd("Obsidian " .. command)
end
function M.toggle_checkbox()
  if vim.bo.filetype ~= "markdown" then return end
  if package.loaded["obsidian-tasks"] then
    local workspace = require("obsidian-tasks.util.obsidian").workspace_for_path(vim.api.nvim_buf_get_name(0))
    if workspace then
      vim.cmd("ObsidianTask toggle")
      return
    end
  end
  if Obsidian and Obsidian.opts and vim.b.obsidian_buffer then
    M.run("toggle_checkbox")
    return
  end
  local line = vim.api.nvim_get_current_line()
  local updated, count = line:gsub("^(%s*[-*+]%s+)%[([ xX])%]", function(prefix, state)
    return prefix .. "[" .. (state == " " and "x" or " ") .. "]"
  end, 1)
  if count > 0 then vim.api.nvim_set_current_line(updated) end
end
return M
