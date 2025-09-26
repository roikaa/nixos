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
    ./../../user/app/appluncher/rofi.nix
    ./../../user/app/pass/pass.nix
    ./../../user/style/stylix.nix
    ./../../user/cli/btop.nix
#     inputs.nixvim.homeModules.nixvim
  ];


  home.packages = with pkgs; [
  tealdeer # short manual
  ani-cli   #anime in terminal
#  foot    # terminal

  # core
  brave
  nitch		        # Display system stats
  unrar-wrapper
  unzip 
  git
  zsh
  yazi			# CLI file manager
  #neovim			# Text editor
  

  # Style
  hyprshot
  waybar			# Status bar
  swww			# Wallpaper daemon
  wl-clipboard   # Clipboard
  dunst			# Notification daemon
  libnotify			# Notification daemon's dependency
  #rofi-wayland	        # Application luncher
  
  
  # Dev
  gtk3
  
  
  # Desktop
  libreoffice-qt  # Microssoftoffice ulernative
  obsidian	# not app
  qbittorrent       # Torrent
  baobab # GUI app to analyse disk usage
  #dolphin			# GUI file manager
  

  # Social
  signal-desktop  # Chat app
  #telegram-desktop
  
  # Media
  ffmpeg  #ffmpeg
  mpv
  yt-dlp #youtube smth
  freetube
  komikku

  # Gaming
  lutris 
  heroic 
  # wine

#  open-webui
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
