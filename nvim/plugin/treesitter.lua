-- Treesitter configuration
-- Grammars are provided by nix (nvim-treesitter.withAllGrammars), no setup() needed
-- Highlight and indent are enabled by default in nvim 0.11+ with grammars present

-- Treesitter context (shows enclosing function/class at top of screen)
require("treesitter-context").setup({
  enable = true,
  max_lines = 3,
})
