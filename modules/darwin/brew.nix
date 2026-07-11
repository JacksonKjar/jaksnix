{ inputs, ... }:
{
  flake.modules.darwin.brew = {
    imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];
    nix-homebrew = {
      enable = true;
      user = "jaks";
      autoMigrate = true;
    };
    homebrew = {
      enable = true;
      casks = [
        "firefox"
        "google-chrome"
        "codex-app"
      ];
    };
  };
}
