{pkgs, lib, config, ...}:
{
  programs.rofi = {
    enable = true;
    #pass.enable = true;

    extraConfig = {
    show-icons = true;
    #modi = "drun,run,ssh,window,pass:rofi-pass";
    # Other configuration options...
  };
  };

}
