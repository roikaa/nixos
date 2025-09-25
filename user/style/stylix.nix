{ config, pkgs, inputs, ... }: {

   stylix = {
    enable = true;
   #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"; # Example scheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    targets.nixvim.enable = true;
    #targets.foot.enable = true;
  };


}   
