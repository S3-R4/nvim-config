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

--- DIAGNOSTICS
-- Show diagnostics in a floating window under cursor
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = "Show diagnostics in float" })

-- Go to next/previous diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- Open diagnostics in location list
-- dl (diagnostics list)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Open diagnostics in location list" })

-- Toggle virtual lines for diagnostics (Neovim 0.10+)
vim.keymap.set('n', '<leader>dt', function() -- dt (diagnostigs toggle)
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual lines" })

vim.keymap.set('n', '<leader>Q', function()
  vim.diagnostic.setqflist({ open = true })
end, { desc = "Open diagnostics in quickfix list" })
---;;; END OF DIAGNOSTICS

vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })

-- Bufferline: Move buffer left/right by count (default 1)
local function move_buffer(direction, count)
  count = count or 1
  for _ = 1, count do
    if direction == "left" then
      vim.cmd("BufferLineMovePrev")
    elseif direction == "right" then
      vim.cmd("BufferLineMoveNext")
    end
  end
end

vim.keymap.set("n", "<leader>hh", function()
  local count = vim.v.count
  move_buffer("left", count == 0 and 1 or count)
end, { silent = true, desc = "Move buffer left by count" })

vim.keymap.set("n", "<leader>ll", function()
  local count = vim.v.count
  move_buffer("right", count == 0 and 1 or count)
end, { silent = true, desc = "Move buffer right by count" })

