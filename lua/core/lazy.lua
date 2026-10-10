local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(path) then
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", path })
  if vim.v.shell_error ~= 0 then
    error("Could not install lazy.nvim:\n" .. result)
  end
end
vim.opt.rtp:prepend(path)
require("lazy").setup({ { import = "plugins" } }, {
  defaults = { lazy = true },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } },
  },
})
