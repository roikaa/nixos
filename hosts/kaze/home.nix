{ config, pkgs, lib, inputs, ... }:
{
  home.username = "akio";
  home.homeDirectory = "/home/akio";
  
  imports = [
    ./../../user/wm/hyprland/hyprland.nix
    ./../../user/shell/zsh.nix
    ./../../user/app/browser/librewolf.nix
    ./../../user/app/terminal/foot.nix
    ./../../user/app/terminal/kitty.nix
    ./../../user/app/obs/obs.nix
    ./../../user/app/noevim/nixvim.nix
    ./../../user/app/discord/nixcord.nix
    ./../../user/style/stylix.nix
    ./../../user/cli/btop.nix
#     inputs.nixvim.homeModules.nixvim
  ];


  home.packages = with pkgs; [
# bibata-cursors
  tealdeer # short manual
  ani-cli   #anime in terminal
#  btop    # benchmark tool
  foot    # terminal
  ffmpeg  #ffmpeg
  open-webui
#  neovim
  ];

#home.pointerCursor = {
#  gtk.enable = true;
#  #x11.enable = true;
#  package = pkgs.bibata-cursors;
#  name = "Bibata-Modern-Classic";
#  size = 24;
#};

#gtk = {
#  enable = true;
#  theme = {
#    package = pkgs.flat-remix-gtk;
#    name = "Flat-Remix-GTK-Grey-Darkest";
#  };
#
#  iconTheme = {
#    package = pkgs.adwaita-icon-theme;
#    name = "Adwaita";
#  };
#
#};


home.sessionVariables.EDITOR = "nvim";
  programs.git = {
    enable = true;
    userName = "roikaa";
    userEmail = "akio216216@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
    aliases = {
      pu = "push";
      cm = "commit -m";
      co = "checkout";
    };
  };





   home.sessionVariables = {
     MANPAGER="nvim +Man!";
  };


  home.file = {

  };


  home.stateVersion = "24.11"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}
