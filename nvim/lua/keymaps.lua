vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- File tree
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus file tree" })

-- Clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
