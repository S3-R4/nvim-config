local settings = require("config.settings")
return {
  { "mason-org/mason.nvim", cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog" }, opts = {} },
  {
    "neovim/nvim-lspconfig",
    cmd = "InstallServers",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local servers = { "gopls", "clangd", "texlab" }
      if settings.sql.server ~= "" then servers[#servers + 1] = settings.sql.server end
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })
      vim.lsp.config("gopls", {
        settings = { gopls = { usePlaceholders = true, completeUnimported = false, staticcheck = true } },
      })
      vim.lsp.config("clangd", { cmd = { "clangd", "--background-index" } })
      vim.lsp.config("texlab", {
        settings = { texlab = { build = { onSave = false }, chktex = { onEdit = false, onOpenAndSave = false } } },
      })
      require("mason-lspconfig").setup({
        -- Keep fresh installs deliberate and off the startup path.
        ensure_installed = {},
        automatic_enable = false,
      })
      vim.lsp.enable(servers)
      vim.api.nvim_create_user_command("InstallServers", function()
        local packages = { "gopls", "clangd", "jdtls", "texlab" }
        if settings.sql.server ~= "" then
          local mapping = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package
          packages[#packages + 1] = assert(mapping[settings.sql.server], "Unknown Mason SQL server: " .. settings.sql.server)
        end
        vim.cmd("MasonInstall " .. table.concat(packages, " "))
      end, { desc = "Install selected language servers" })
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = { "mason-org/mason.nvim", "saghen/blink.cmp" },
    config = function() require("config.java").start() end,
  },
}
