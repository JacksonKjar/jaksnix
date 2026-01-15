{pkgs, ...}: {
  # Fonts
  home.packages = with pkgs; [
    nerd-fonts.hack
  ];

  programs.alacritty = {
    enable = true;
    theme = "kanagawa_wave";
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
          family = "Hack Nerd Font Mono";
          style = "Regular";
        };
        size = 12;
      };
    };
  };
}
