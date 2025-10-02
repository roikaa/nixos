{ config, lib, pkgs, ...}:
{
  imports = [];
  
  # Console settings (no i18n prefix)
  console.font = "Lat2-Terminus16";
  console.keyMap = "us";
  
  # Locale setting (with i18n prefix)
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Fonts
  fonts.packages = with pkgs; [
    carlito
    ipafont
    kochi-substitute
  ];

  # Environment variables for IME
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    GLFW_IM_MODULE = "ibus";
  };
  
  # Input Method Editor
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc ];
  };
}
