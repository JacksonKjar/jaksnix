{
  inputs,
  lib,
  ...
}:
{
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
  };

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
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
      rebase.autostash = true;
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
