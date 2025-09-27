{pkgs, lib, config, ...}:
{
  programs.rofi = {
    enable = true;
#pass.enable = true;

    extraConfig = {
      show-icons = true;
      width = 900;
      lines = 15;
      columns = 1;
      dpi = 120;  # Increase this value for bigger icons (default is usually 96)
        spacing = 2;
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        icon-size = mkLiteral "52px";  # Change this value for different icon sizes (24px, 48px, etc.)
      };
  };

  };
}


