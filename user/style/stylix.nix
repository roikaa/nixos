{ config, pkgs, lib, inputs, ... }: 
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "toggle-gruvbox";
      runtimeInputs = [ pkgs.ripgrep ];
      text = ''
        gen=$(home-manager generations | head -1 | rg -o '/nix/store/[^ ]*')
        if [[ "$gen" =~ light ]]; then
          "$(home-manager generations | sed -n 2p | rg -o '/nix/store/[^ ]*')/activate"
        else
          "$gen/specialisation/light/activate"
        fi
      '';
    })
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    polarity = "dark";
    targets = {
      firefox.profileNames = [ "roika" ];
      neovim.enable = true;
      rofi.enable = true;
      foot.enable = true;
      tmux.enable = true;
      btop.enable = true;
      kitty.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
      zathura.enable = true;
    };
    autoEnable = false;  
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    iconTheme = {
      enable = true;
      package = pkgs.gruvbox-plus-icons;
      light = "Gruvbox-Plus-Light";
      dark = "Gruvbox-Plus-Dark";
    };
  };
  
  # Add home-manager specialisation
  specialisation.light.configuration = {
    stylix = {
      base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/gruvbox-light-medium.yaml";
      polarity = lib.mkForce "light";
    };
  };
}   
