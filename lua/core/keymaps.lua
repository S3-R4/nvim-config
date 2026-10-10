local map = vim.keymap.set
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
map("n", "<leader>hh", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>ll", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Diagnostic details" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Buffer diagnostics" })
map("n", "<leader>Q", vim.diagnostic.setqflist, { desc = "Project diagnostics" })
map("n", "<leader>dt", function()
  local enabled = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = not enabled })
end, { desc = "Toggle diagnostic lines" })
map("n", "<leader>st", function()
  vim.cmd("botright 15split")
  vim.cmd.terminal()
  vim.cmd.startinsert()
end, { desc = "Terminal split" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
map("n", "<leader>nv", "<cmd>Notes<cr>", { desc = "Open notes vault" })
map("n", "<leader>uc", "<cmd>ConfigSettings<cr>", { desc = "Edit shared settings" })
map("n", "<leader>ul", "<cmd>ConfigLocal<cr>", { desc = "Edit machine settings" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(args)
    local opts = { buffer = args.buf }
    local function bind(key, fn, desc)
      map("n", key, fn, vim.tbl_extend("force", opts, { desc = desc }))
    end
    bind("<leader>gd", function() Snacks.picker.lsp_definitions() end, "Goto definition")
    bind("gd", function() Snacks.picker.lsp_definitions() end, "Goto definition")
    bind("<leader>gt", function() Snacks.picker.lsp_type_definitions() end, "Goto type definition")
    bind("gr", function() Snacks.picker.lsp_references() end, "References")
    bind("gI", function() Snacks.picker.lsp_implementations() end, "Implementations")
    bind("K", vim.lsp.buf.hover, "Hover documentation")
    bind("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    bind("<leader>ca", vim.lsp.buf.code_action, "Code actions")
    bind("<leader>cs", vim.lsp.buf.signature_help, "Signature help")
    -- No formatting or organize-imports hooks: changes are always explicit.
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.documentOnTypeFormattingProvider = nil
    end
  end,
})
