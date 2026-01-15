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
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.cl-nix-lite.url = "github:r4v3n6101/cl-nix-lite/url-fix";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, ... }: {
    # Home Manager modules (cross-platform)
    homeModules = {
      shell = ./modules/shell.nix;
      gui = ./modules/gui.nix;
      nix = ./modules/nix.nix;
      nvf = ./modules/nvf.nix;
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
  };
}
