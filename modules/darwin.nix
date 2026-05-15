{
  inputs,
  config,
  self,
  ...
}:
{
  flake.darwinConfigurations."Jacksons-MacBook-Pro-3" = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      inputs.home-manager.darwinModules.home-manager
      inputs.mac-app-util.darwinModules.default
    ]
    ++ builtins.attrValues config.flake.modules.darwin;
  };
}
