-- Filetype detection for Brazil Config files
-- Brazil Config uses a perl-like DSL with braces and semicolons
vim.filetype.add({
  filename = {
    ["Config"] = "ruby",
  },
})
