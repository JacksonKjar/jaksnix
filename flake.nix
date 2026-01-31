{
  description = "Jackson's nixfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
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
      # Home Manager modules (cross-platform)
      homeModules = {
        shell = ./modules/shell.nix;
        gui = ./modules/gui.nix;
        nix = ./modules/nix.nix;
        nvf = ./modules/nvf.nix;
      };

      homeConfigurations."jaks" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = { inherit inputs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./hm-configs/jaks.nix
          ./modules/shell.nix
          ./modules/gui.nix
          ./modules/nix.nix
          ./modules/nvf.nix
        ];
      };

      # Darwin modules (macOS only)
      darwinModules = {
        # Add darwin modules here when ready
      };

      # Templates
      templates = {
        default = {
          path = ./templates/default;
          description = "Basic development environment with direnv";
        };
      };

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              # Add your development tools here
            ];

            shellHook = ''
              echo "Development environment loaded"
            '';
          };
        }
      );

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
