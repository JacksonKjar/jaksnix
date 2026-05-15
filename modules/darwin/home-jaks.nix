{ inputs, config, ... }:
{
  flake.modules.darwin.home-jaks = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.jaks = {
      home.username = "jaks";
      home.homeDirectory = "/Users/jaks";
      home.stateVersion = "25.11";
      imports = [
        inputs.mac-app-util.homeManagerModules.default
      ]
      ++ builtins.attrValues config.flake.modules.homeManager;
    };
  };
}
