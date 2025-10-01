{pkgs, config, lib, ...}:
{
  programs.firefox = {
    enabel = true;
    package = firefox-esr
  };
}
