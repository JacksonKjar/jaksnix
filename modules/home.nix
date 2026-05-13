{ inputs, config, ... }:
{
  flake.homeConfigurations.jaks = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
    modules = [
      inputs.mac-app-util.homeManagerModules.default
      {
        home.username = "jaks";
        home.homeDirectory = "/Users/jaks";
        home.stateVersion = "25.11";
        home.packages = [ ];
        home.file = { };
        home.sessionVariables = { };
      }
    ] ++ builtins.attrValues config.flake.modules.homeManager;
  };
}
