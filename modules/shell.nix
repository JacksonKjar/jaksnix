{
  inputs,
  lib,
  ...
}: {
  # Add ~/.local/bin to PATH
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Vi mode for readline (Python REPL, etc.)
  home.file.".inputrc".text = ''
    set editing-mode vi
    set keymap vi-insert
  '';

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    shellAliases = {
      hm = "home-manager";
      ls = "exa";
      la = "ls -Al";
      zj = "zellij";
    };
    initContent = ''
      # Test nixfiles changes and rebuild home-manager
      hmtest() {
        local msg="''${1:-wip: testing changes}"
        local nixfiles_dir="$HOME/.config/nixfiles"
        local hm_dir="$HOME/.config/home-manager"
        
        echo "📦 Checking nixfiles changes..."
        cd "$nixfiles_dir" || return 1
        
        if [[ -z $(git status --porcelain) ]]; then
          echo "✓ No changes to commit"
        else
          echo "\n📝 Changes to commit:"
          git diff --stat
          echo ""
          git add -A
          git commit -m "$msg"
          echo "✓ Committed changes"
        fi
        
        echo "\n🔄 Updating flake and rebuilding..."
        cd "$hm_dir" || return 1
        nix flake update nixfiles
        home-manager switch --flake .
        
        if [[ $? -eq 0 ]]; then
          echo "\n✓ Rebuild successful!"
          echo "\n📤 Pushing to GitHub..."
          cd "$nixfiles_dir"
          git push
          echo "✓ Pushed to GitHub"
        else
          echo "\n✗ Rebuild failed - not pushing"
          return 1
        fi
      }
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zellij = {
    enable = true;
    settings.theme = "ansi";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Jackson Kjar";
      user.email = lib.mkDefault "jackson@kjar.me";
      color.ui = "auto";
      push.default = "simple";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };

  programs.helix = {
    enable = true;
    settings.theme = "kanagawa";
  };

  imports = [
    ./nvf.nix
  ];
  programs.nvf = {
    enable = true;
  };

  programs.gitui.enable = true;
}
