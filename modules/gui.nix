{ pkgs, ... }:
{
  # Fonts
  home.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  programs.alacritty = {
    enable = true;
    theme = "gruvbox_dark";
    settings = {
      window.opacity = 0.9;
      window.option_as_alt = "OnlyLeft";
      keyboard.bindings = [
        {
          key = "F";
          mods = "Command|Shift";
          action = "ToggleSimpleFullscreen";
        }
      ];
      font = {
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        size = 12;
      };
    };
  };
}
