{pkgs, lib, config, ...}:
{
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
  enable = true;
  efiSupport = true;
  device = "nodev";
  useOSProber = false;
  gfxmodeEfi = "auto";
  };
}
