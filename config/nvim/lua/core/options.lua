-- Example options (add your own later)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Swap file configuration (cross-platform: Windows & Linux)
vim.opt.swapfile = true                                    -- Enable swap files for crash recovery
vim.opt.updatecount = 100                                  -- Write swap file after 100 characters typed
vim.opt.directory = vim.fn.stdpath('data') .. '/swap//'    -- Centralized swap directory (// = full path encoding)

-- Auto-delete swap files older than 7 days on startup (cross-platform)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local swap_dir = vim.fn.stdpath('data') .. '/swap'
    
    -- Ensure swap directory exists
    vim.fn.mkdir(swap_dir, 'p')
    
    -- Cross-platform cleanup: delete .swp files older than 7 days
    local is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
    
    if is_windows then
      -- Windows: Use PowerShell to delete old swap files
      local ps_cmd = string.format(
        'powershell -Command "Get-ChildItem -Path \'%s\' -Filter *.swp | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force"',
        swap_dir
      )
      vim.fn.system(ps_cmd)
    else
      -- Linux/Unix: Use find command
      local find_cmd = string.format('find "%s" -name "*.swp" -mtime +7 -delete 2>/dev/null', swap_dir)
      vim.fn.system(find_cmd)
    end
  end,
})
