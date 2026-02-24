{
  # config,
  # lib,
  pkgs,
  inputs,
  ...
}:
# let
# tokyo-night-sddm = pkgs.libsForQt5.callPackage ./../../system/sddm/tokyo-night.nix { };
# in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../system/essentials/boot.nix
    ./../../system/essentials/font.nix
    ./../../system/essentials/applications.nix
    ./../../system/hardware/keyboard/default.nix
    ./../../system/hardware/nvidia.nix
    ./../../system/services/maintenance.nix
    ./../../system/style/stylix.nix
    #     ./../../system/app/open-webui.nix
    ./../../system/inputs/japanese.nix
    #      ./../../system/hardware/printer.nix
    # ./../../system/app/ollama.nix

    inputs.home-manager.nixosModules.default
  ];

  networking.hostName = "kaze"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [22];
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no"; # recommended for security
    };
  };
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
    extraGroups = ["wheel" "plugdev"]; #sudo enable
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
    extraSpecialArgs = {inherit inputs;};
    users = {
      "akio" = import ./home.nix;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
      inherit pkgs;
    };
  };
  environment.systemPackages = with pkgs; [
  ];

  programs.thunar.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses; # or "qt", "mac", etc.
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

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

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "tokyo-night-sddm";
    # extraPackages = [tokyo-night-sddm];
  };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
