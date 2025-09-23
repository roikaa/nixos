# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../system/hardware/kanataKeyboard.nix
      ./../../system/font.nix
      ./../../system/hardware/nvidia.nix
      ./../../system/steam.nix
#      ./../../modules/ollama.nix
      ./../../system/open-webui.nix
#      ./../../modules/mysql/mysql.nix
      #./../../modules/zsh.nix
      inputs.home-manager.nixosModules.default
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kaze"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

  # Set your time zone.
  time.timeZone = "Etc/GMT-1";

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # User account 
  users.users.akio = {
  useDefaultShell = true;
  isNormalUser = true;
  description = "akio";
  #shell = pkgs.zsh;
  extraGroups = [ "wheel" ]; #sudo enable
  packages = with pkgs; [
  ];
 };


 nixpkgs.config.allowUnfree = true;

# Automatic updating
system.autoUpgrade = {
  enable = true;
  dates = "weekly";
};

# Automatic cleanup
nix = {
  gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
  settings.auto-optimise-store = true;
};

  home-manager = {
   # (ref vimjoyer Ultimate NixOS Guide)
   backupFileExtension = "backup";
   extraSpecialArgs = { inherit inputs; };
   users = {
   "akio" = import ./home.nix;
   };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


services.printing.drivers = [ pkgs.cnijfilter2 ];
services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    libreoffice-qt  # Microssoftoffice ulernative
    signal-desktop  # Chat app
    discord-ptb     # Discord
    obsidian
#    transmission_4-qt   # Torrent
    qbittorrent       # Torrent
    mpv
    yt-dlp
    lutris    # gaming lancher
    heroic    # game lancher
#    wine      # to run .exe windows
#    zed-editor   # IDE
#    vscode # VSCode IDE
#    android-studio
#    kdePackages.kdenlive
#    davinci-resolve
unrar-wrapper
#telegram-desktop
unzip

baobab

    openssl
    zig
    hyprshot
    nodejs
    glib
#    libxml2
    gtk3
    nix-index
#    firefox-devedition
    freetube
komikku
     wget			
     git			 
     nix-ld			# ( idk what is this but ig some work around for some apps that dont work in nixos)
#     kitty                      # Terminal
     rofi-wayland	        # Application luncher
     nitch		        # Display system stats
     neovim			# Text editor
     waybar			# Status bar
     dunst			# Notification daemon
     libnotify			# Notification daemon's dependency
     swww			# Wallpaper daemon
     yazi			# CLI file manager
     pass			# CLI password manager
     gnupg  # gpg encrytion for pass
      pinentry      # for gnupg
     pinentry-curses    #for gnupg
     wl-clipboard   # Clipboard
#     dolphin			# GUI file manager
   ];

programs.thunar.enable = true;
 
programs.gnupg.agent = {
  enable = true;
  enableSSHSupport = true;
  pinentryPackage = pkgs.pinentry-curses ;  # or "qt", "mac", etc.
};

xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
programs.nix-ld.enable = true;

programs.hyprland = {
  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  enable = true;
  xwayland.enable = true;
};
environment.variables.EDITOR = "nvim";
environment.sessionVariables = {
LIBVA_DRIVER_NAME = "nvidia";
XDG_SESSION_TYPE = "wayland";
WLR_NO_HARDWARE_CURSORS = "1";
NIXOS_OZONE_WL = "1";
};
 
#services.xserver.enable = true;
services.xserver.displayManager.sddm.enable = true;
services.displayManager.sddm.wayland.enable = true;
 

 # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

