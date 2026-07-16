-- Lualine (statusline)
require("lualine").setup({
  options = { theme = "gruvbox" },
})

-- Bufferline (tabs)
require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
  },
})

-- Indent blankline
require("ibl").setup()

-- Gitsigns
require("gitsigns").setup()

-- Todo comments
require("todo-comments").setup()

-- Neo-tree (pass empty config table explicitly)
require("neo-tree").setup({
  filesystem = {
    follow_current_file = { enabled = true },
  },
})

-- Which-key
require("which-key").setup()

-- Nvim-notify
require("notify").setup({
  stages = "slide",
})
vim.notify = require("notify")

-- Noice
require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  presets = {
    bottom_search = true,
    long_message_to_split = true,
    command_palette = true,
  },
})

-- Autopairs
require("nvim-autopairs").setup()

-- Comment
require("Comment").setup()

-- Surround
require("nvim-surround").setup()

-- Trouble
require("trouble").setup()
vim.keymap.set("n", "<leader>ld", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix" })

-- Fidget (LSP progress)
require("fidget").setup()

-- Lightbulb (code actions)
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })

-- Diffview
require("diffview").setup()

-- Colorizer
require("colorizer").setup()

-- Highlight undo
require("highlight-undo").setup()

-- Smartcolumn
require("smartcolumn").setup({
  custom_colorcolumn = {
    nix = "100",
    java = "120",
    kotlin = "120",
    scala = "120",
    python = "88",
  },
})
