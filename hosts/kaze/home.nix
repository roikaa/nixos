{ config, pkgs, lib, inputs, ... }:
{
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
    ./../../user/app/appluncher/rofi.nix
    ./../../user/app/pass/pass.nix
    ./../../user/style/stylix.nix
    ./../../user/cli/btop.nix
    ./../../user/app/development/android.nix
    ./../../user/keepass/default.nix
    ./../../user/app/LaTex/default.nix
    ./../../user/neovim/default.nix
    ./../../user/app/Tmux/default.nix
    ./../../user/app/zathura/default.nix
    ./../../user/wm/status-bar/waybar/style.nix
    ./../../user/wm/status-bar/waybar/default.nix
  ];

  programs.foliate.enable = true; # Ebook reader
 
programs.freetube = {
    enable = true;
    package = pkgs.freetube;
  };

  stylix.targets = {
    waybar.enable = true;
  };

  home.packages = with pkgs; [
    tealdeer # short manual
      ani-cli   #anime in terminal
      neofetch
    telegram-desktop

ascii-image-converter
      nitch		        # Display system statshome.nix
      git
      zsh
      yazi			# CLI file manager
    nnn

# Style
      hyprshot
      swww			# Wallpaper daemon
      wl-clipboard   # Clipboard
     # swaynotificationcenter      # notification for waybar

      libnotify			# Notification daemon's dependency

# Dev
      gtk3
      mtpfs


# Desktop
      # libreoffice-qt  # Microssoftoffice ulernative
#foliate	# eBook reader
      obsidian	# not app
      qbittorrent       # Torrent
      baobab # GUI app to analyse disk usage
thunderbird


    komikku

      feh

      ffmpeg  # ffmpeg 
      mpv
      yt-dlp # cli tool downloding video/audio
cinny-desktop
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





  home.sessionVariables = {
    MANPAGER="nvim +Man!";
  };


  home.file = {

  };
  
  home.shellAliases = {
    srebuild = "sudo nixos-rebuild switch --flake ~/MyRepos/nixos#kaze";
  };
  

    home.stateVersion = "24.11"; # Please read the comment before changing.
    programs.home-manager.enable = true;
}
