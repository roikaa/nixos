{config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
# davinci-resolve-studio
    shotcut
    libsForQt5.kdenlive
  ];
}
