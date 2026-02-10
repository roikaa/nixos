
{ config, lib, pkgs, inputs, ... }:
let 
     tokyo-night-sddm = pkgs.libsForQt5.callPackage ./../sddm/tokyo-night.nix { };
in 
{
  environment.systemPackages = with pkgs; [
    tokyo-night-sddm
    ntfs3g # windows filesystem driver
    python312Packages.pip
    python3Full
    tree
    bat
      usbutils
      openssl
      android-tools  # for adb/fastboot
      zig
      gcc
      nodejs
      glib
      vim
      wget			
      git	
      nix-index
      nix-ld			# ( idk what is this but ig some work around for some apps that dont work in nixos)
      sysstat
      pass			# CLI password manager
      gnupg  # gpg encrytion for pass
      pinentry      # for gnupg
      pinentry-curses    #for gnupg
      unrar-wrapper
      unzip 

  ];
}
