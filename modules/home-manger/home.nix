{ config, pkgs, lib, ... }:
{
  home.username = "akio";
  home.homeDirectory = "/home/akio";
  
  imports = [
    ./../hyprland.nix
    ./../zsh.nix
    ./../librewolf.nix
  ];


  home.packages = with pkgs; [
# bibata-cursors
  tealdeer
 
  ];

  

home.pointerCursor = {
  gtk.enable = true;
  #x11.enable = true;
  package = pkgs.bibata-cursors;
  name = "Bibata-Modern-Classic";
  size = 24;
};

gtk = {
  enable = true;
  theme = {
    package = pkgs.flat-remix-gtk;
    name = "Flat-Remix-GTK-Grey-Darkest";
  };

  iconTheme = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
  };

  font = {
    name = "JetBrainsMono";
    size = 11;
  };
};


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
