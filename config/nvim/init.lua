require("core.customPaths")
require("core.options")
require("core.keymaps")

require("plugins.lazy")

vim.opt.termguicolors = true
require("bufferline").setup{}

require("plugins.lsp")