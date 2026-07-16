-- ftplugin/kotlin.lua
-- Kotlin LSP with Brazil/Bemol workspace support
-- Uses nvim 0.11+ native vim.lsp API

local root_dir = vim.fs.root(0, { ".bemol", "packageInfo", "Config", ".git", "build.gradle.kts", "build.gradle" })
if not root_dir then
  return
end

local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, path = root_dir, type = "directory" })[1]

vim.lsp.config("kotlin_language_server", {
  root_markers = { ".bemol", "packageInfo", "Config", ".git", "build.gradle.kts", "build.gradle" },
  filetypes = { "kotlin" },
  on_attach = function(client, bufnr)
    if bemol_dir then
      local file = io.open(bemol_dir .. "/ws_root_folders", "r")
      if file then
        for line in file:lines() do
          vim.lsp.buf.add_workspace_folder(line)
        end
        file:close()
      end
    end
  end,
})

vim.lsp.enable("kotlin_language_server")
