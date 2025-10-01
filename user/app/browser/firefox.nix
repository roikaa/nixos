{pkgs, meta, config, lib, ...}:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
  };
}
