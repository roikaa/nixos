{ config, pkgs, inputs, ... }: {

   stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/sakura.yaml";
    targets.nixvim.enable = true;

    cursor = {
     package = pkgs.bibata-cursors;
     name = "Bibata-Modern-Ice";
     size = 24;
    };

   };
}   
