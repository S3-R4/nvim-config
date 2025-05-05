-- Set leader key
vim.g.mapleader = " " -- space is the leader key. its like Super or Win button but for vim
vim.g.maplocalleader = " "



--- Keybindings
-- vim.keymap.set("n", "<C-e>f", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) -- its for toggling the file explorer
---;;;END OF Keybindings

--- nvim-telescope keybinds
vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

-- Alternatively, using lua API
vim.keymap.set("n", "<space>fb", function()
	require("telescope").extensions.file_browser.file_browser()
end)
---;;;;END OF nvim-telescope keybinds