{ inputs, pkgs, ... }:
{
  imports = [ inputs.nvf.homeManagerModules.default ];
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = false;
      vimAlias = true;

      # Editor settings
      options = {
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;
        softtabstop = 2;
        autoindent = true;
        smartindent = true;
      };

      # Custom keybindings
      keymaps = [
        {
          key = "<leader>e";
          mode = [ "n" ];
          action = ":Neotree toggle<CR>";
          desc = "Toggle file tree";
        }
        {
          key = "<leader>o";
          mode = [ "n" ];
          action = ":Neotree focus<CR>";
          desc = "Focus file tree";
        }

        # Clipboard Copy/Paste
        {
          key = "<leader>y";
          mode = [
            "n"
            "v"
          ];
          action = ''"+y'';
          desc = "Yank to clipboard";
        }
        {
          key = "<leader>p";
          mode = [
            "n"
            "v"
          ];
          action = ''"+p'';
          desc = "Paste from clipboard";
        }
      ];

      # Spellcheck
      spellcheck.enable = false;

      # LSP Configuration
      lsp = {
        enable = true;
        formatOnSave = false;
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
        nix.format.type = [ "nixfmt" ];

        java.enable = true;
        kotlin.enable = true;
        scala.enable = true;
        python.enable = true;
        rust.enable = true;
        go.enable = true;
        clojure.enable = true;

        # Useful extras
        markdown = {
          enable = true;
          lsp.enable = false;
        };
        bash.enable = true;
        json.enable = true;
        lua.enable = true; # for nvim config
      };

      repl.conjure.enable = true;
      # Visual enhancements
      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        fidget-nvim.enable = true; # LSP progress indicator
        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };

      # Statusline
      statusline.lualine.enable = true;

      # Theme
      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
        transparent = true;
      };

      # Autopairs
      autopairs.nvim-autopairs.enable = true;

      # Autocomplete
      autocomplete.blink-cmp = {
        enable = true;
        setupOpts = {
          completion.list.selection = {
            preselect = false;
            auto_insert = true;
          };
          cmdline.completion.list.selection = {
            preselect = false;
            auto_insert = true;
          };
        };
      };
      snippets.luasnip.enable = true;

      # File tree
      filetree.neo-tree.enable = true;

      # Buffer tabs
      tabline.nvimBufferline.enable = true;

      # Treesitter context (shows function/class at top when scrolling)
      treesitter = {
        context.enable = true;
      };

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
      notify.nvim-notify = {
        enable = true;
        setupOpts.stages = "slide";
      };

      # Utility
      utility = {
        diffview-nvim.enable = true;
        surround.enable = true;

        icon-picker.enable = true;
      };

      # Comments
      comments.comment-nvim.enable = true;

      # Notes
      notes = {
        todo-comments.enable = true;
      };

      # UI enhancements
      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
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
      lazy.plugins = with pkgs.vimPlugins; {
        nvim-paredit = {
          package = nvim-paredit;
          setupModule = "nvim-paredit";
          ft = [
            "clojure"
            "fennel"
            "scheme"
            "lisp"
            "janet"
          ];
        };
      };
    };
  };
}
