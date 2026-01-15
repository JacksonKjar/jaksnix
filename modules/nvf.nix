{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = false;
      vimAlias = true;

      # Custom keybindings
      keymaps = [
        {
          key = "<leader>e";
          mode = ["n"];
          action = ":Neotree toggle<CR>";
          silent = true;
          desc = "Toggle file tree";
        }
        {
          key = "<leader>o";
          mode = ["n"];
          action = ":Neotree focus<CR>";
          silent = true;
          desc = "Focus file tree";
        }
      ];

      # Spellcheck
      spellcheck.enable = false;

      # LSP Configuration
      lsp = {
        enable = true;
        formatOnSave = true;
        lightbulb.enable = true;
        trouble.enable = true;
        lspSignature.enable = false; # conflicts with blink-cmp
      };

      # Language Support
      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        # Core languages
        nix.enable = true;
        java.enable = true;
        kotlin.enable = true;
        scala.enable = true;
        python.enable = true;

        # Useful extras
        markdown.enable = true;
        bash.enable = true;
        json.enable = true;
        lua.enable = true; # for nvim config
      };

      # Visual enhancements
      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        fidget-nvim.enable = true; # LSP progress indicator
        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };

      # Statusline
      statusline.lualine = {
        enable = true;
        theme = "gruvbox";
      };

      # Theme
      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
        transparent = false;
      };

      # Autopairs
      autopairs.nvim-autopairs.enable = true;

      # Autocomplete
      autocomplete.blink-cmp.enable = true;
      snippets.luasnip.enable = true;

      # File tree
      filetree.neo-tree.enable = true;

      # Buffer tabs
      tabline.nvimBufferline.enable = true;

      # Treesitter context (shows function/class at top when scrolling)
      treesitter.context.enable = true;

      # Keybinding discovery
      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      # Telescope (fuzzy finder)
      telescope.enable = true;

      # Git integration
      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      # Notifications
      notify.nvim-notify.enable = true;

      # Utility
      utility = {
        diffview-nvim.enable = true;
        surround.enable = true;
        icon-picker.enable = true;
      };

      # Comments
      comments.comment-nvim.enable = true;

      # Todo highlighting
      notes.todo-comments.enable = true;

      # UI enhancements
      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        illuminate.enable = true; # highlight word under cursor
        breadcrumbs = {
          enable = true;
          navbuddy.enable = false; # keep breadcrumbs minimal
        };
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            nix = "100";
            java = "120";
            kotlin = "120";
            scala = "120";
            python = "88";
          };
        };
      };
    };
  };
}
