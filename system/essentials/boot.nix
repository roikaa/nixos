{pkgs, ...}: let
  grubtheme = pkgs.fetchFromGitHub {
    owner = "roikaa";
    repo = "grubtheme";
    rev = "ddfb35d647171f11b42a06339b0854f43e72149e";
    sha256 = "sha256-6oW4GW5OOhYrDoU21DbxwzQyls5W08Dgi2hc1BWdQaQ="; # Compute via ➜ nix-prefetch-github roikaa grubtheme
  };
in {
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot"; # CRITICAL - tells NixOS where EFI is
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = false;
    gfxmodeEfi = "auto";
    theme = "${grubtheme}/sayonara";
  };
}
