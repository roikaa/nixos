{ config, pkgs, inputs, ... }: {

   stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"; # Example scheme
    autoEnable = true;
    targets.neovim.enable = true;
  };


}   
