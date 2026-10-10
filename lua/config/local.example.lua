-- Copy to local.lua on each machine; local.lua is ignored by Git.
return {
  notes = {
    vault = "", -- absolute path to your existing Obsidian vault
  },
  sql = {
    server = "", -- fill in after choosing your SQL server
    -- Prefer environment variables for passwords/connection strings.
    connections = {},
  },
  remote = {
    enabled = true,
    host = "", -- an SSH alias from ~/.ssh/config or user@host
  },
  latex = { viewer = "zathura" },
}
