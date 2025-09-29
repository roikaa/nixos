# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
      ./../../system/essentials/boot.nix
      ./../../system/essentials/font.nix
      ./../../system/hardware/kanataKeyboard.nix
      ./../../system/hardware/nvidia.nix
      ./../../system/services/maintenance.nix
      ./../../system/style/stylix.nix
      ./../../system/app/steam.nix
      ./../../system/app/open-webui.nix
      ./../../system/app/kdeconnect.nix
#      ./../../system/hardware/printer.nix

      inputs.home-manager.nixosModules.default
    ];


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
    extraGroups = [ "wheel" "plugdev"]; #sudo enable
      packages = with pkgs; [
      ];
  };
  services.udev.extraRules = ''
# Samsung Download Mode
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", ATTR{idProduct}=="685d", MODE="0666", GROUP="plugdev"
# Samsung devices in download mode
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
    '';

  nixpkgs.config.allowUnfree = true;



  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
# (ref vimjoyer Ultimate NixOS Guide)
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "akio" = import ./home.nix;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


#services.printing.drivers = [ pkgs.cnijfilter2 ];
#services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    dotnetCorePackages.sdk_7_0
      dotnet-runtime_9
      python312Packages.pip
      python3Full
      tree
      usbutils
      openssl
      heimdall-gui
      android-tools  # for adb/fastboot
      heimdall
      wine
      winetricks
      zig
      nodejs
      glib
      vim
      wget			
      git	
      nix-index
      nix-ld			# ( idk what is this but ig some work around for some apps that dont work in nixos)
      pass			# CLI password manager
      gnupg  # gpg encrytion for pass
      pinentry      # for gnupg
      pinentry-curses    #for gnupg
      ];
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-7.0.410"
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
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;


# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

