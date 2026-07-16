require("blink.cmp").setup({
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },
  },
  cmdline = {
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
