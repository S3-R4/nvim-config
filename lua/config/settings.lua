-- Shared preferences. Machine-specific values belong in lua/config/local.lua.
local settings = {
  theme = "kanagawa-wave", -- also: omni-blackout, catppuccin-mocha
  notes = {
    vault = vim.env.NVIM_NOTES_VAULT or "",
  },
  sql = {
    server = vim.env.NVIM_SQL_SERVER or "", -- e.g. sqls; empty disables SQL LSP
    connections = {}, -- Dadbod entries: { name = "local", url = "..." }
  },
  remote = {
    enabled = true, -- gates the optional bin/nvim-remote launcher
    host = vim.env.NVIM_REMOTE_HOST or "",
  },
  latex = {
    viewer = "zathura",
  },
  features = {
    image = true,
    scroll = true,
    catppuccin = true, -- available for comparison; one active theme
    wayfinder = true,
    git_history = true, -- Fugitive + Flog
    add_subtract = true,
    goplexity = false, -- initial hints state; plugin is available on demand
  },
}

local ok, machine = pcall(require, "config.local")
if ok then
  settings = vim.tbl_deep_extend("force", settings, machine)
elseif not tostring(machine):match("module 'config.local' not found") then
  error(machine)
end
-- Per-launch overrides win over saved machine settings.
if vim.env.NVIM_NOTES_VAULT then settings.notes.vault = vim.env.NVIM_NOTES_VAULT end
if vim.env.NVIM_SQL_SERVER then settings.sql.server = vim.env.NVIM_SQL_SERVER end
if vim.env.NVIM_REMOTE_HOST then settings.remote.host = vim.env.NVIM_REMOTE_HOST end
return settings
