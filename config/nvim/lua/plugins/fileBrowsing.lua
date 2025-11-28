require("telescope").setup  {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        file_ignore_patterns = {
            "node_modules", ".git/", "target", "build", "%.lock"
        },
    },
    pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
           hidden = true,
        },
      },
      
    extensions = {
      file_browser = {
        theme = "ivy",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        hidden = true,
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
          },
          ["n"] = {
            -- your custom normal mode mappings
          },
        },
      },
    },
  }
  -- To get telescope-file-browser loaded and working with telescope,
  -- you need to call load_extension, somewhere after setup function:
  require("telescope").load_extension "file_browser"
  require('telescope').load_extension('harpoon')
  require('telescope').load_extension('projects')




-- its for project-nvim
local M = {}

M.opts = {
  manual_mode = false,
  detection_methods = { 'lsp', 'pattern' },
  patterns = { '.git', 'Makefile', 'package.json' },
  show_hidden = true,
  silent_chdir = true,
  scope_chdir = 'global',
  ignore_lsp = { "null-ls" },
  exclude_dirs = {
    "~/.cargo/*",
    "~/AppData/*",
    "*/node_modules/*",
    "*/.git/*",
    "*/target/*",
    "*/build/*",
  },
}

M.setup = function()
  require('project_nvim').setup(M.opts)
end

return M