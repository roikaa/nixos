{ config, pkgs, inputs, ... }: 
{
stylix.targets.firefox.profileNames = [ "roika" ];
# this is home-manager stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
#base16Scheme = "${pkgs.base16-schemes}/share/themes/sakura.yaml";

    targets = {
      neovim.enable = true;
      rofi.enable = true;
      foot.enable = true;
      tmux.enable = true;
      btop.enable = true;
      kitty.enable = true;
      hyprland.enable = true;
    };
autoEnable = false;  
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    iconTheme = { 
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus";
    };

       #  fonts.sizes.applications = 14;
#    iconTheme = {
#      enable = true;
#      package = pkgs.gruvbox-plus-icons;
#      light = "Gruvbox-Plus-Light";
#      dark = "Gruvbox-Plus-Dark";
#    };
  };
}   
