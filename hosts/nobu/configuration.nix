{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
./../../system/style/stylix.nix
./../../system/essentials/font.nix
      ./../../system/hardware/keyboard/thinkpad.nix
inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

hardware.graphics.extraPackages = with pkgs; [ vaapiIntel intel-media-driver ];
hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
programs.zsh.enable = true;
users.defaultUserShell = pkgs.zsh;
  users.users.ala = {
    isNormalUser = true;
    description = "ala";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
# (ref vimjoyer Ultimate NixOS Guide)
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ala" = import ./home.nix;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses ;  # or "qt", "mac", etc.
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  programs.nix-ld.enable = true;

environment.sessionVariables = {
  XDG_SESSION_TYPE = "wayland";
  NIXOS_OZONE_WL = "1";
};
  programs.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable = true;
    xwayland.enable = true;
  };
  # environment.variables.EDITOR = "vim";
  # Install firefox.
  # programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
zig
gcc
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nodejs
git  
nix-ld
pass
gnupg
pinentry
pinentry-curses
glib
   ciscoPacketTracer8
    ntfs3g # windows filesystem driver
      python312Packages.pip
      python3Full
 
];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # networking.firewall.enable = false;

  system.stateVersion = "25.05"; # Did you read the comment?
}
