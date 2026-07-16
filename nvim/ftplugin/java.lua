-- ftplugin/java.lua
-- Java LSP (jdtls) with Brazil/Bemol integration
-- Uses nvim 0.11+ native vim.lsp API

local home = os.getenv("HOME")

-- Find root: prefer .bemol (Brazil), then standard markers
local root_dir = vim.fs.root(0, { ".bemol", "packageInfo", "Config", ".git", "build.gradle", "pom.xml" })
if not root_dir then
  return
end

-- Per-workspace data directory (avoids jdtls cache collisions)
local workspace_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local jdtls_data_dir = home .. "/.cache/jdtls/workspace/" .. workspace_name

-- Read bemol workspace folders for cross-package go-to-definition
local ws_folders = {}
local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, path = root_dir, type = "directory" })[1]
if bemol_dir then
  local file = io.open(bemol_dir .. "/ws_root_folders", "r")
  if file then
    for line in file:lines() do
      table.insert(ws_folders, "file://" .. line)
    end
    file:close()
  end
end

-- Lombok support: path provided by nix via nixCats('lombok_jar')
local lombok_jar = nixCats("lombok_jar")
local cmd = { "jdtls", "-configuration", home .. "/.cache/jdtls/config", "-data", jdtls_data_dir }
if lombok_jar and lombok_jar ~= "" and lombok_jar ~= false then
  table.insert(cmd, "--jvm-arg=-javaagent:" .. lombok_jar)
end

-- Configure and start jdtls
vim.lsp.config("jdtls", {
  cmd = cmd,
  root_markers = { ".bemol", "packageInfo", "Config", ".git", "build.gradle", "pom.xml" },
  filetypes = { "java" },
  init_options = {
    workspaceFolders = ws_folders,
  },
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
  settings = {
    java = {
      configuration = {
        runtimes = {
          { name = "JavaSE-17", path = os.getenv("JAVA_HOME_17") or "" },
          { name = "JavaSE-21", path = os.getenv("JAVA_HOME_21") or "" },
        },
      },
    },
  },
})

vim.lsp.enable("jdtls")
