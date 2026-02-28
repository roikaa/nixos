{
  config,
  pkgs,
  lib,
  inputs,
  unstable,
  ...
}: let
  grubtheme = pkgs.fetchFromGitHub {
    owner = "roikaa";
    repo = "grubtheme";
    rev = "ddfb35d647171f11b42a06339b0854f43e72149e";
    sha256 = "sha256-6oW4GW5OOhYrDoU21DbxwzQyls5W08Dgi2hc1BWdQaQ="; # Compute via ➜ nix-prefetch-github roikaa grubtheme
  };
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../system/style/stylix.nix
    ./../../system/essentials/font.nix
    ./../../system/essentials/applications.nix
    ./../../system/hardware/keyboard/thinkpad.nix
    ./../../system/services/maintenance.nix
    inputs.home-manager.nixosModules.default

    ./../../user/univercity/default.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.gfxmodeEfi = "auto";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.theme = "${grubtheme}/sayonara";
  # let
  # colorsheme = "night";
  # layout = "teleport";
  # resolution = "1920x1080";
  # in

  hardware.graphics.extraPackages = with pkgs; [vaapiIntel intel-media-driver];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  networking.hostName = "nobu"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Algiers";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # services.xserver.enable = true;
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -c 'dwl -s waybar' ";
  #       user = "greeter";
  #     };
  #   };
  # };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = let
          start-dwl = pkgs.writeShellScript "start-dwl" ''
            mkdir -p ~/.cache
            exec ${pkgs.coreutils}/bin/stdbuf -oL dwl -s waybar > ~/.cache/dwltags
          '';
        in "${pkgs.greetd.tuigreet}/bin/tuigreet -t -c ${start-dwl}";
        user = "greeter";
      };
    };
  };

  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  #   # theme = "tokyo-night-sddm";
  # };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.power-profiles-daemon.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.akio = {
    isNormalUser = true;
    description = "akio";
    extraGroups = ["networkmanager" "wheel" "plugdev"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };
  services.udev.extraRules = ''
    # Samsung Download Mode
        SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", ATTR{idProduct}=="685d", MODE="0666", GROUP="plugdev"
    # Samsung devices in download mode
        SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
  '';

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # (ref vimjoyer Ultimate NixOS Guide)
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs;
      inherit unstable;
    };
    users = {
      "akio" = import ./home.nix;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses; # or "qt", "mac", etc.
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  programs.nix-ld.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.0";
  };

  programs.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable = true;
    xwayland.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  programs.thunar.enable = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [22];

  system.stateVersion = "25.05"; # Did you read the comment?
}
