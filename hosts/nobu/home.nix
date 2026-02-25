{ config, pkgs, lib, inputs, unstable, ... }:
{
  home.username = "akio";
  home.homeDirectory = "/home/akio";

  imports = [
    ./../../user/wm/dwl/dwl.nix
    ./../../user/wm/hyprland/thinkpad.nix
    ./../../user/shell/default.nix
    ./../../user/app/browser/librewolf.nix
    ./../../user/app/browser/firefox.nix
    ./../../user/app/terminal/foot.nix
    ./../../user/app/terminal/kitty.nix
    ./../../user/app/obs/obs.nix
    ./../../user/app/appluncher/rofi.nix
    ./../../user/app/pass/pass.nix
    ./../../user/style/stylix.nix
    ./../../user/cli/btop.nix
    ./../../user/app/LaTex/default.nix
    ./../../user/neovim/default.nix
    ./../../user/app/Tmux/default.nix
    ./../../user/app/zathura/default.nix

    ./../../user/wm/status-bar/waybar/style.nix
    ./../../user/wm/status-bar/waybar/default.nix
    
    ./../../user/frivolous/default.nix

    ./../../user/cli/musicPlayer/rmpc.nix

  ];

  programs.foliate.enable = true; # Ebook reader
 
programs.freetube = {
    enable = true;
    package = pkgs.freetube;
  };

  home.packages = 
    (with pkgs; [

    tealdeer # short manual
      ani-cli   #anime in terminal
      telegram-desktop

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
      # dunst			# Notification daemon
      libnotify			# Notification daemon's dependency
     # swaynotificationcenter      # notification for waybar

# Dev
      gtk3
      mtpfs

# Desktop
      libreoffice-qt  # Microssoftoffice ulernative
      obsidian	# not app
      qbittorrent       # Torrent
      baobab # GUI app to analyse disk usage


# Social
      signal-desktop  # Chat app
# Media
      feh
      ffmpeg  
      mpv
      komikku
    ])

    ++

    (with unstable; [
     yt-dlp # cli tool downloding video/audio

    ]);

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
    srebuild = "sudo nixos-rebuild switch --flake ~/MyRepos/nixos#nobu";
  };
  home.sessionVariables = {
    MANPAGER="nvim +Man!";
  };


  home.file = {

  };
  
  home.stateVersion = "24.11"; # Please read the comment before changing.
    programs.home-manager.enable = true;
}
