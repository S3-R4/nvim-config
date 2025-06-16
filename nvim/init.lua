
require("plugins.lazy")
require("core.options")
require("core.keymaps")



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
