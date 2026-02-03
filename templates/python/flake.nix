{
  description = "Python development environment with uv";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              uv
              python3
            ];

            shellHook = ''
              if [ ! -f pyproject.toml ]; then
                uv init
                echo "Initialized Python project with uv"
              fi
            '';
          };
        }
      );
    };
}
