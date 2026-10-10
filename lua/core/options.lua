local opt = vim.opt
-- Optional tools installed alongside this portable configuration.
vim.env.PATH = vim.fn.stdpath("config") .. "/bin:" .. vim.env.PATH
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.showmode = false
opt.laststatus = 3
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.wrap = false
opt.breakindent = true
opt.undofile = true
opt.swapfile = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.formatoptions:remove({ "t", "a" })
opt.shortmess:append("I")

-- Native syntax folding fallback. Treesitter overrides this where available.
opt.foldmethod = "manual"
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserEditingOptions", { clear = true }),
  callback = function(args)
    -- Filetype plugins may reintroduce automatic text wrapping.
    vim.bo[args.buf].formatoptions = vim.bo[args.buf].formatoptions:gsub("[ta]", "")
    if vim.bo[args.buf].filetype == "go" then
      vim.bo[args.buf].expandtab = false
      vim.bo[args.buf].tabstop = 4
      vim.bo[args.buf].shiftwidth = 4
    end
  end,
})

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
  virtual_lines = false,
  underline = true,
  float = { border = "rounded", source = true },
})
