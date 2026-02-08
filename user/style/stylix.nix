{ config, pkgs, lib, inputs, ... }: 
{
home.packages = [
  (pkgs.writeShellApplication {
    name = "nightman";
    runtimeInputs = [ pkgs.ripgrep pkgs.home-manager ];
    text = ''
      current=$(home-manager generations | head -1 | rg -o '/nix/store/[^ ]*')
      
      # Check if the light specialisation activation script exists
      if [[ -f "$current/specialisation/light/activate" ]]; then
        # We're in dark (base), switch to light
        "$current/specialisation/light/activate"
      else
        # We're in light, go back to the previous generation (dark)
        previous=$(home-manager generations | sed -n 2p | rg -o '/nix/store/[^ ]*')
        "$previous/activate"
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
