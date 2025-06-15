require("core.customPaths")
require("core.options")
require("core.keymaps")

require("plugins.lazy")

require("bufferline").setup{  
    options = {
        numbers = function(opts)
            return string.format('%s', opts.raise(opts.ordinal))
        end,
    }
}

require("nvim-autopairs").setup {}

require("plugins.lsp")

require('mtoc').setup({})


vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("cd S:\\")
  end
})
