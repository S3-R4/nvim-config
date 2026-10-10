local root = assert(arg[1], "configuration root is missing")
package.path = root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua;" .. package.path
local settings = require("config.settings")
io.write(tostring(settings.remote.enabled), "\n", vim.env.NVIM_REMOTE_HOST or settings.remote.host, "\n")
