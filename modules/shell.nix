{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./nvf.nix
  ];

  # Add ~/.local/bin to PATH
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Vi mode for readline (Python REPL, etc.)
  home.file.".inputrc".text = ''
    set editing-mode vi
    set keymap vi-insert
  '';

  home.packages = with pkgs; [
    tldr # better man
    choose # better cut/awk
    dust # better du
    duf # better df
    awscli2
    duckdb
    nodejs
    (python3.withPackages (ps: with ps; [
      ipython
      numpy
      polars
      pandas
      matplotlib
    ]))
  ];

  programs = {
    nvf.enable = true;
    ripgrep.enable = true;
    bat.enable = true;
    jq.enable = true;
    fd.enable = true;
    htop.enable = true;
    uv.enable = true;
    nushell.enable = true;

    zsh = {
      enable = true;
      defaultKeymap = "viins";
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      shellAliases = {
        hm = "home-manager";
        ls = "eza";
        la = "ls -Al";
        zj = "zellij";
      };
      initContent = ''
        nfit() {
          nix flake init -t "git+ssh://git@github.com/JacksonKjar/nixfiles#$1"
        }
      '';
    };

    lazygit = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zellij = {
      enable = true;
      settings.theme = lib.mkDefault "ansi";
      settings.show_startup_tips = false;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
    };

    git = {
      enable = true;
      settings = {
        user.name = "Jackson Kjar";
        user.email = lib.mkDefault "jackson@kjar.me";
        color.ui = "auto";
        init.defaultBranch = "main";
        push.default = "simple";
        push.autoSetupRemote = true;
        pull.rebase = true;
        rebase.autostash = true;
      };
    };

    helix = {
      enable = true;
      settings.theme = "kanagawa";
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
