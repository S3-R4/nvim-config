-- Set leader key
vim.g.mapleader = " " -- space is the leader key. its like Super or Win button but for vim
vim.g.maplocalleader = " "

-- nvim-telescope keybinds
vim.keymap.set("n", "<leader>tb", function()
    require("telescope").extensions.file_browser.file_browser({
      path = vim.fn.expand("%:p:h"), -- start at current buffer’s folder
      select_buffer = true,
      grouped = true,
      hidden = true,
      respect_gitignore = false,
    })
  end, { desc = "File browser at current file path" })  


  vim.keymap.set("n", "<leader>tp", ":Telescope projects<CR>", { desc = "Find Projects" }) -- its for project-nvim
  vim.keymap.set('n', '<leader>tf', ":Telescope find_files<CR>", { desc = 'Telescope find files' })
  vim.keymap.set("n", "<leader>tb", ":Telescope buffers<CR>")
  -- vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
  vim.keymap.set('n', '<leader>ntt', ':cd %:p:h<CR>:NvimTreeToggle<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>ntf', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
---;;;;END OF nvim-telescope keybinds

--- harpoon keybinds
vim.keymap.set("n", "<leader>ha", function() require("harpoon.mark").add_file() end)
vim.keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end)

for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>")
  end

vim.keymap.set("n", "<leader>hm", ":Telescope harpoon marks<CR>", { desc = "Telescope Harpoon Marks" })
---;;;END OF harpoon keybinds
