{ config, pkgs, lib, inputs, ... }:
{
   programs.zathura = {
  enable = true;
  extraConfig = ''
      set selection-clipboard clipboard
  '';
};
}
