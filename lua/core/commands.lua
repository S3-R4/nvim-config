local settings = require("config.settings")
local function edit_config(path)
  vim.cmd.edit(vim.fn.fnameescape(vim.fn.stdpath("config") .. "/" .. path))
end
vim.api.nvim_create_user_command("ConfigSettings", function()
  edit_config("lua/config/settings.lua")
end, { desc = "Edit shared configuration preferences" })
vim.api.nvim_create_user_command("ConfigLocal", function()
  local path = vim.fn.stdpath("config") .. "/lua/config/local.lua"
  if vim.fn.filereadable(path) == 0 then
    local example = vim.fn.stdpath("config") .. "/lua/config/local.example.lua"
    vim.fn.writefile(vim.fn.readfile(example), path)
  end
  edit_config("lua/config/local.lua")
end, { desc = "Edit machine-specific settings" })
vim.api.nvim_create_user_command("Notes", function()
  if settings.notes.vault == "" or vim.fn.isdirectory(vim.fn.expand(settings.notes.vault)) == 0 then
    vim.notify("Set notes.vault to an existing vault with :ConfigLocal, then restart Neovim.", vim.log.levels.WARN)
    return
  end
  Snacks.picker.files({ cwd = vim.fn.expand(settings.notes.vault), title = "Notes" })
end, { desc = "Find a note in your vault" })
vim.api.nvim_create_user_command("RemoteStatus", function()
  vim.notify(string.format("Remote launcher: %s\nHost: %s\nrnvim: %s\nUse bin/nvim-remote for remote editing; nvim always starts locally.",
    settings.remote.enabled and "enabled" or "disabled",
    settings.remote.host ~= "" and settings.remote.host or "not configured",
    vim.fn.executable("rnvim") == 1 and "installed" or "not installed"))
end, { desc = "Show optional remote launcher settings" })
vim.api.nvim_create_user_command("ConfigHealth", function()
  local commands = { "git", "rg", "fd", "tree-sitter", "gcc", "go", "java", "latexmk", settings.latex.viewer, "magick", "rnvim" }
  local lines = { "Neovim " .. tostring(vim.version()), "Notes vault: " .. (settings.notes.vault ~= "" and settings.notes.vault or "not configured") }
  for _, command in ipairs(commands) do
    lines[#lines + 1] = command .. ": " .. (vim.fn.executable(command) == 1 and "found" or "missing")
  end
  if vim.fn.executable("leaf") == 0 and vim.fn.executable("glow") == 0 and vim.fn.executable("pandoc") == 0 then
    lines[#lines + 1] = "Beside renderer: missing (install leaf, glow, or pandoc)"
  end
  vim.notify(table.concat(lines, "\n"))
end, { desc = "Check external tools for this configuration" })
