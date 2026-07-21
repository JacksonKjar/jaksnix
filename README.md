# jaksnix

Personal Nix configuration modules for home-manager.

## Modules

- `shell` - Shell configuration (zsh, starship, direnv, eza, git, helix, neovim)
- `gui` - GUI applications (alacritty)
- `nix` - Nix settings and configuration
- `nvf` - Neovim configuration via nvf

## Usage

Add to your flake inputs:

```nix
inputs.jaksnix = {
  url = "github:JacksonKjar/jaksnix";
  inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.follows = "home-manager";
};
```

Import modules:

```nix
imports = [
  inputs.jaksnix.homeModules.shell
  inputs.jaksnix.homeModules.gui
  inputs.jaksnix.homeModules.nix
];
```
