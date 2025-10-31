{ config, pkgs, lib, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
in{
  home.username = "akio";
  home.homeDirectory = "/home/akio";

  imports = [
    ./../../user/wm/hyprland/thinkpad.nix
    ./../../user/shell/default.nix
    ./../../user/app/browser/librewolf.nix
    ./../../user/app/browser/firefox.nix
    ./../../user/app/terminal/foot.nix
    ./../../user/app/terminal/kitty.nix
    ./../../user/app/obs/obs.nix
    ./../../user/app/discord/nixcord.nix
    ./../../user/app/appluncher/thinkpad.nix
    ./../../user/app/pass/pass.nix
    ./../../user/style/stylix.nix
    ./../../user/cli/btop.nix
    # ./../../user/app/development/android.nix
    # ./../../user/keepass/default.nix
    ./../../user/app/LaTex/default.nix
    ./../../user/neovim/default.nix
    ./../../user/app/Tmux/default.nix
    ./../../user/app/zathura/default.nix
    # ./../../user/wm/bar/default.nix

    ./../../user/wm/status-bar/waybar/style.nix
    ./../../user/wm/status-bar/waybar/default.nix
    
    ./../../user/frivolous/default.nix

    ./../../user/cli/musicPlayer/rmpc.nix
  ];

  programs.foliate.enable = true; # Ebook reader
    # programs.waybar.enable = true;
  # xdg.configFile."waybar/config.jsonc".source = ./../../user/wm/waybar/config;
# conflicting with stylix, use if stylix nolt enabled
 # xdg.configFile."waybar/style.css".source = ./../../user/wm/waybar/style.css;
 
programs.freetube = {
    enable = true;
    package = pkgs.freetube;
    # additional settings if needed
  };
  home.packages = with pkgs; [
    gns3-gui
    gns3-server

    tealdeer # short manual
      ani-cli   #anime in terminal

# core
      unrar-wrapper
      unzip 
      git
      zsh
      yazi			# CLI file manager
    nnn

# Style
      hyprshot
      swww			# Wallpaper daemon
      wl-clipboard   # Clipboard
      dunst			# Notification daemon
      libnotify			# Notification daemon's dependency
#rofi-wayland	        # Application luncher


# Dev
      gtk3
      mtpfs

# Desktop
      libreoffice-qt  # Microssoftoffice ulernative
#foliate	# eBook reader
      obsidian	# not app
      qbittorrent       # Torrent
      baobab # GUI app to analyse disk usage
#dolphin			# GUI file manager


# Social
      signal-desktop  # Chat app
#telegram-desktop

# Media
      feh
      ffmpeg  
      mpv
      unstable.yt-dlp # cli tool downloding video/audio
      komikku
    ciscoPacketTracer8

      ];

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




  home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos#nobu";
  };
  home.sessionVariables = {
    MANPAGER="nvim +Man!";
  };


  home.file = {

  };
  
  home.stateVersion = "24.11"; # Please read the comment before changing.
    programs.home-manager.enable = true;
}
