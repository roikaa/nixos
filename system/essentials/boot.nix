{pkgs, inputs, ...}: 
let
  grubshin = pkgs.fetchFromGitHub {
    owner = "roikaa";
    repo = "grubtheme";
    rev = "61929a9b7b1e8ee3d2a368bcd9ba9bb568bb4002";
    sha256 = "sha256-OAm6JkSmuKdELqlcqdM+dCUjMFemXefRFbGVCmnS16I="; # Compute via ➜ nix-prefetch-github roikaa grubtheme
  };
in
  {
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot"; # CRITICAL - tells NixOS where EFI is
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = false;
    gfxmodeEfi = "auto";
    theme = "${grubshin}/teleport-night-1280x720";

  };
}
