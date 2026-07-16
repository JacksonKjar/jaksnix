{ inputs, self, ... }:
{
  flake.modules.homeManager.nixcats =
    { pkgs, ... }:
    {
      imports = [ inputs.nixCats.homeModules.default ];

      # nixCats module configuration
      # The default package name from nixCats is "nixCats", so options are under "nixCats.*"
      nixCats = {
        enable = true;
        packageNames = [ "nvim" ];
        luaPath = "${self}/nvim";

        # Category definitions: what nix provides per category
        categoryDefinitions.replace = { pkgs, ... }: {
          # LSP servers and tools available at runtime (on PATH inside nvim)
          lspsAndRuntimeDeps = {
            general = with pkgs; [
              ripgrep
              fd
            ];
            java = with pkgs; [
              jdt-language-server
              lombok
            ];
            kotlin = with pkgs; [
              kotlin-language-server
            ];
            python = with pkgs; [
              pyright
            ];
            rust = with pkgs; [
              rust-analyzer
            ];
            go = with pkgs; [
              gopls
            ];
            nix = with pkgs; [
              nil
            ];
            clojure = with pkgs; [
              clojure-lsp
            ];
            lua = with pkgs; [
              lua-language-server
            ];
            bash = with pkgs; [
              bash-language-server
            ];
          };

          # Plugins loaded at startup
          startupPlugins = {
            general = with pkgs.vimPlugins; [
              # LSP
              nvim-lspconfig
              fidget-nvim
              nvim-lightbulb
              trouble-nvim

              # Completion
              blink-cmp
              friendly-snippets
              luasnip

              # Telescope
              telescope-nvim
              plenary-nvim

              # UI
              gruvbox-nvim
              lualine-nvim
              bufferline-nvim
              indent-blankline-nvim
              nvim-notify
              noice-nvim
              nui-nvim
              nvim-web-devicons
              dressing-nvim
              which-key-nvim
              smartcolumn-nvim
              nvim-colorizer-lua
              highlight-undo-nvim
              todo-comments-nvim

              # File tree
              neo-tree-nvim

              # Git
              gitsigns-nvim
              vim-fugitive
              diffview-nvim

              # Editing
              nvim-autopairs
              comment-nvim
              nvim-surround

              # Treesitter
              nvim-treesitter.withAllGrammars
              nvim-treesitter-context
            ];

            clojure = with pkgs.vimPlugins; [
              conjure
              nvim-paredit
            ];

            rust = with pkgs.vimPlugins; [
              rustaceanvim
            ];
          };

          optionalPlugins = {};
        };

        # Package definitions: what to build
        packageDefinitions.replace = {
          nvim = { pkgs, ... }: {
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = true;
              aliases = [ "vim" ];
            };
            categories = {
              general = true;
              java = true;
              kotlin = true;
              python = true;
              rust = true;
              go = true;
              nix = true;
              clojure = true;
              lua = true;
              bash = true;
              lombok_jar = "${pkgs.lombok}/share/java/lombok.jar";
            };
          };
        };
      };
    };
}
