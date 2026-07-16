-- LSP configuration (nvim 0.11+ native API)
-- No require('lspconfig') needed — uses vim.lsp.config + vim.lsp.enable

-- Shared on_attach: bemol workspace folder loading
local function on_attach(client, bufnr)
  local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })[1]
  if bemol_dir then
    local file = io.open(bemol_dir .. "/ws_root_folders", "r")
    if file then
      for line in file:lines() do
        vim.lsp.buf.add_workspace_folder(line)
      end
      file:close()
    end
  end
end

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Global defaults for all LSP servers
vim.lsp.config("*", {
  root_markers = { ".git" },
  on_attach = on_attach,
})

-- Enable simple servers (binary must be on PATH, provided by nix categories)
vim.lsp.enable({
  "nil_ls",
  "pyright",
  "gopls",
  "clojure_lsp",
  "lua_ls",
  "bashls",
  "jsonls",
})

-- Rust is handled by rustaceanvim
-- Java and Kotlin are configured in ftplugin/
