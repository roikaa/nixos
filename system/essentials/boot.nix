{pkgs, inputs, ...}: 
let
  cybergrub = pkgs.fetchFromGitHub {
    owner = "adnksharp";
    repo = "CyberGRUB-2077";
    rev = "86ed7c3af18c3b69dd002b341dbb099daaf39eab"; # Or specific commit hash for reproducibility, e.g., "v1.0"
    sha256 = "sha256-quXluKYzylSnUnbLZbzdygM5pgDwB1PgLV4VAU66Lc0="; # Compute via `nix-prefetch-github adnksharp CyberGRUB-2077`
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
    theme = "${cybergrub}/CyberGRUB-2077";
    # theme = inputs.grubshin-bootpact.night.teleport."1280x720";

  };
  #   boot.loader.grub.theme = let
  #   colorscheme = "night";
  #   layout = "teleport";
  #   resolution = "1280x720";
  # in inputs.grubshin-bootpact.${colorscheme}.${layout}.${resolution};
}
