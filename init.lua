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

-- Auto change to workspace directory on startup (cross-platform)
-- Only changes directory if opened with a file argument
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- If opened with a file, change to its directory
    local first_arg = vim.fn.argv(0)
    if first_arg ~= "" and vim.fn.isdirectory(first_arg) == 0 then
      local file_dir = vim.fn.fnamemodify(first_arg, ":p:h")
      vim.cmd("cd " .. vim.fn.fnameescape(file_dir))
    end
    -- Otherwise, stay in current directory (don't hardcode S:\)
  end
})

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
    ["html"] = {
      enable_close = true
    }
  }
})
