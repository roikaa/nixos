{config, pkgs, lib, ...}:
{
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-extra  # Includes Arabic and many other scripts
    # OR specifically:
    # amiri  # Traditional Arabic typeface
    # scheherazade-new  # Arabic font
    noto-fonts
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.iosevka
    inter
    eb-garamond

  ];
}
