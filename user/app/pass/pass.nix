{pkgs, lib, config, ...}:
{
 home.packages = with pkgs; [
    xorg.xset
    #xdotool
    rofi-pass-wayland
    wtype
  ];


  programs.rofi.pass.extraConfig = 
    ''
      URL_field='url'
      USERNAME_field='email'
    '';

  programs.password-store = {
    enable = true;


    # settings = {
    #   PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
    # };
  };
}
