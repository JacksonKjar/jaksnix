{ ... }:
{
  flake.modules.homeManager.nix =
    { pkgs, ... }:
    {
      nix = {
        package = pkgs.nix;
        gc.automatic = true;
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
}
