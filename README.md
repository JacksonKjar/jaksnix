# nixfiles

Personal Nix configuration modules for home-manager.

## Modules

- `shell` - Shell configuration (zsh, starship, direnv, eza, git, helix, neovim)
- `gui` - GUI applications (alacritty)
- `nix` - Nix settings and configuration
- `nvf` - Neovim configuration via nvf

## Usage

Add to your flake inputs:

```nix
inputs.nixfiles = {
  url = "github:yourusername/nixfiles";
  inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.follows = "home-manager";
};
```

Import modules:

```nix
imports = [
  inputs.nixfiles.homeModules.shell
  inputs.nixfiles.homeModules.gui
  inputs.nixfiles.homeModules.nix
];
```
