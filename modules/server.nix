{ inputs, config, ... }:
let
  # When invoked with --impure, reads $USER/$HOME/system. Otherwise defaults to jkjar/x86_64-linux.
  username = let u = builtins.getEnv "USER"; in if u != "" then u else "jkjar";
  homedir = let h = builtins.getEnv "HOME"; in if h != "" then h else "/home/${username}";
  system = builtins.currentSystem or "x86_64-linux";

  mkServer = sys: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${sys};
    modules = [
      {
        home.username = username;
        home.homeDirectory = homedir;
        home.stateVersion = "25.11";
        programs.zsh.shellAliases.jaksnix-update =
          "nix run github:JacksonKjar/jaksnix#homeConfigurations.server.activationPackage --no-write-lock-file --impure";
      }
    ] ++ builtins.attrValues config.flake.modules.homeManager;
  };
in
{
  # Auto-detect: use `nix run .#homeConfigurations.server.activationPackage --impure`
  flake.homeConfigurations.server = mkServer system;

  # Explicit arch pins (work without --impure for system detection)
  flake.homeConfigurations.server-x86_64 = mkServer "x86_64-linux";
  flake.homeConfigurations.server-aarch64 = mkServer "aarch64-linux";
}
