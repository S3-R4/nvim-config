local M = {}
function M.preview_pdf()
  if not require("config.settings").features.image then
    vim.notify("Enable features.image to preview PDFs with Snacks.", vim.log.levels.WARN)
    return
  end
  local ok, pdf = pcall(vim.fn.eval, "b:vimtex.compiler.get_file('pdf')")
  if not ok or type(pdf) ~= "string" or vim.fn.filereadable(pdf) == 0 then
    vim.notify("Compile the LaTeX document with Space lc before previewing its PDF.", vim.log.levels.WARN)
    return
  end
  vim.cmd.vsplit(vim.fn.fnameescape(pdf))
end
return M
