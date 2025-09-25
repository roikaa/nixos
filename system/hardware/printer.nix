{pkgs, lib, config, ...}:

let
  canon-capt = pkgs.stdenv.mkDerivation {
    pname = "canon-capt";
    version = "2.71";
        src = /etc/nixos/canon-capt-driver;
    installPhase = ''
      mkdir -p $out/lib/cups/filter
      mkdir -p $out/share/cups/model
      cp usr/lib/cups/filter/* $out/lib/cups/filter/
      cp usr/share/cups/model/*.ppd $out/share/cups/model/
      chmod 755 $out/lib/cups/filter/*
    '';
  };
in
{

  # Enable CUPS printing service
  services.printing = {
    enable = true;
    drivers = with pkgs; [
    canon-capt
    canon-cups-ufr2
    cups-filters
    gutenprint
    hplip  # Sometimes helps with generic support
  ];
  };

  # Enable USB printer support
  services.udev.packages = with pkgs; [ cups ];
  
  # Optional: enable printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
