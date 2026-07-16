local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/", "build/" },
  },
})

local map = vim.keymap.set
map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fr", builtin.resume, { desc = "Resume search" })
-- LSP pickers
map("n", "<leader>flr", builtin.lsp_references, { desc = "LSP references" })
map("n", "<leader>fld", builtin.lsp_definitions, { desc = "LSP definitions" })
map("n", "<leader>fli", builtin.lsp_implementations, { desc = "LSP implementations" })
map("n", "<leader>fls", builtin.lsp_document_symbols, { desc = "Document symbols" })
