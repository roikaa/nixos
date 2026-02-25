{
  pkgs,
  lib,
  ...
}: let
  gruvbox-icons-full = pkgs.gruvbox-plus-icons.overrideAttrs (oldAttrs: {
    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/icons
      cp -r Gruvbox-Plus-Dark $out/share/icons/
      cp -r Gruvbox-Plus-Light $out/share/icons/
      runHook postInstall
    '';
  });
in {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "nightman";
      runtimeInputs = [pkgs.ripgrep pkgs.home-manager pkgs.libnotify];
      text = ''
        set -euo pipefail

        cleanup() {
          notify-send "Theme Switch" "Theme switch interrupted!" -u critical
          exit 1
        }
        trap cleanup INT TERM

        current=$(home-manager generations | head -1 | rg -o '/nix/store/[^ ]*')

        # Check if the light specialisation activation script exists
        if [[ -f "$current/specialisation/light/activate" ]]; then
          # We're in dark (base), switch to light
          notify-send "Theme Switch" "Switching to light mode..." -t 2000
          if "$current/specialisation/light/activate"; then
            notify-send "Theme Switch" "Switched to light mode ☀️" -t 3000
          else
            notify-send "Theme Switch" "Failed to switch to light mode!" -u critical
            exit 1
          fi
        else
          # We're in light, go back to the previous generation (dark)
          previous=$(home-manager generations | sed -n 2p | rg -o '/nix/store/[^ ]*')
          if [[ -z "$previous" ]]; then
            notify-send "Theme Switch" "Cannot find dark mode generation!" -u critical
            exit 1
          fi
          notify-send "Theme Switch" "Switching to dark mode..." -t 2000
          if "$previous/activate"; then
            notify-send "Theme Switch" "Switched to dark mode 🌙" -t 3000
          else
            notify-send "Theme Switch" "Failed to switch to dark mode!" -u critical
            exit 1
          fi
        fi
      '';
    })
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    polarity = "dark";
    targets = {
      librewolf.enable = true;
      librewolf.profileNames = ["roikaa"];
      firefox.profileNames = ["default"];
      rofi.enable = true;
      foot.enable = true;
      tmux.enable = true;
      btop.enable = true;
      kitty.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
      zathura.enable = true;
      gtk.enable = true;
      qt.enable = true;
    };
    autoEnable = true;
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 24;
    };
    iconTheme = {
      enable = true;
      package = gruvbox-icons-full;
      light = "Gruvbox-Plus-Light";
      dark = "Gruvbox-Plus-Dark";
    };
  };

  # Add home-manager specialisation
  specialisation.light.configuration = {
    stylix = {
      base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/gruvbox-material-light-medium.yaml";
      polarity = lib.mkForce "light";
    };
  };
}
