{pkgs, config, lib, ...}:
{

  home.packages = with pkgs; [
    pkgs.android-studio
    ];
}
