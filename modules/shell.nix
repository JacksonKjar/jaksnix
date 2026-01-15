{
  inputs,
  lib,
  ...
}: {
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
}
