{ config, pkgs, lib, inputs, ... }:
{
  home.username = "akio";
  home.homeDirectory = "/home/akio";

  imports = [
    ./../../user/wm/hyprland/hyprland.nix
    ./../../user/shell/zsh.nix
    ./../../user/app/browser/librewolf.nix
    ./../../user/app/browser/firefox.nix
    ./../../user/app/terminal/foot.nix
    ./../../user/app/terminal/kitty.nix
    ./../../user/app/obs/obs.nix
    ./../../user/app/discord/nixcord.nix
    ./../../user/app/appluncher/rofi.nix
    ./../../user/app/pass/pass.nix
    ./../../user/style/stylix.nix
    ./../../user/cli/btop.nix
    ./../../user/app/development/android.nix
    ./../../user/keepass/default.nix
    ./../../user/app/LaTex/default.nix
    ./../../neovim/default.nix
    ./../../user/app/Tmux/default.nix
  ];

  programs.foliate.enable = true; # Ebook reader
    programs.waybar.enable = true;
  xdg.configFile."waybar/config.jsonc".source = ./../../user/wm/waybar/config;
# conflicting with stylix, use if stylix nolt enabled
#  xdg.configFile."waybar/style.css".source = ./../../user/wm/waybar/style.css;
 

  home.packages = with pkgs; [
    tealdeer # short manual
      ani-cli   #anime in terminal
      neofetch
#  foot    # terminal

# core
#brave
      nitch		        # Display system statshome.nix
      unrar-wrapper
      unzip 
      git
      zsh
      yazi			# CLI file manager
#neovim			# Text editor


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
      #libreoffice-qt  # Microssoftoffice ulernative
#foliate	# eBook reader
      obsidian	# not app
      qbittorrent       # Torrent
      baobab # GUI app to analyse disk usage
#dolphin			# GUI file manager
#     kdePackages.dolphin
#      nautilus


# Social
      signal-desktop  # Chat app
#telegram-desktop

# Media
      feh
      ffmpeg  # ffmpeg 
      mpv
      yt-dlp # best for downloding video/audio
      freetube
      komikku
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
     programs.zathura = {
  enable = true;
  extraConfig = ''
    # Notifications
    set notification-error-bg       "rgba(40,40,40,1)"
    set notification-error-fg       "rgba(251,73,52,1)"
    set notification-warning-bg     "rgba(40,40,40,1)"
    set notification-warning-fg     "rgba(250,189,47,1)"
    set notification-bg             "rgba(40,40,40,1)"
    set notification-fg             "rgba(184,187,38,1)"
    
    # Completion menu
    set completion-bg               "rgba(80,73,69,1)"
    set completion-fg               "rgba(235,219,178,1)"
    set completion-group-bg         "rgba(60,56,54,1)"
    set completion-group-fg         "rgba(146,131,116,1)"
    set completion-highlight-bg     "rgba(131,165,152,1)"
    set completion-highlight-fg     "rgba(80,73,69,1)"
    
    # Index mode
    set index-bg                    "rgba(80,73,69,1)"
    set index-fg                    "rgba(235,219,178,1)"
    set index-active-bg             "rgba(131,165,152,1)"
    set index-active-fg             "rgba(80,73,69,1)"
    
    # Input bar
    set inputbar-bg                 "rgba(40,40,40,1)"
    set inputbar-fg                 "rgba(235,219,178,1)"
    
    # Status bar
    set statusbar-bg                "rgba(80,73,69,1)"
    set statusbar-fg                "rgba(235,219,178,1)"
    
    # Highlighting
    set highlight-color             "rgba(250,189,47,0.5)"
    set highlight-active-color      "rgba(254,128,25,0.5)"
    
    # Default colors
    set default-bg                  "rgba(40,40,40,1)"
    set default-fg                  "rgba(235,219,178,1)"
    
    # Rendering
    set render-loading              true
    set render-loading-bg           "rgba(40,40,40,1)"
    set render-loading-fg           "rgba(235,219,178,1)"
    
    # Recolor mode
    set recolor-lightcolor          "rgba(40,40,40,1)"
    set recolor-darkcolor           "rgba(235,219,178,1)"
    set recolor                     true
    set recolor-keephue             true
  '';
};

  home.stateVersion = "24.11"; # Please read the comment before changing.
    programs.home-manager.enable = true;
}
