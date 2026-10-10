local M = {}
function M.start()
  local jdtls = require("jdtls")
  local group = vim.api.nvim_create_augroup("UserJavaLsp", { clear = true })
  local function attach()
    local executable = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
    if vim.fn.executable(executable) == 0 then executable = vim.fn.exepath("jdtls") end
    if executable == "" or vim.fn.executable(executable) == 0 then
      vim.notify("Install JDT LS with :MasonInstall jdtls, then reopen the Java buffer.", vim.log.levels.WARN)
      return
    end
    local root = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", "build.gradle.kts", ".git" })
    if not root then root = vim.fn.expand("%:p:h") end
    local workspace = vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root, ":t") .. "-" .. vim.fn.sha256(root):sub(1, 12)
    jdtls.start_or_attach({
      cmd = { executable, "-data", workspace },
      root_dir = root,
      capabilities = require("blink.cmp").get_lsp_capabilities(),
      settings = { java = { format = { enabled = false }, saveActions = { organizeImports = false } } },
    })
  end
  vim.api.nvim_create_autocmd("FileType", { group = group, pattern = "java", callback = attach })
  if vim.bo.filetype == "java" then attach() end
end
return M
