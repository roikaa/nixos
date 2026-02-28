{pkgs, ...}: let
  waybar-dwl = pkgs.writeShellScriptBin "waybar-dwl" ''
    # Auto-detect the first enabled monitor at runtime
    monitor=$(${pkgs.wlr-randr}/bin/wlr-randr --json \
      | ${pkgs.jq}/bin/jq -r '[.[] | select(.enabled)][0].name')
    exec ${pkgs.bash}/bin/bash \
      ${./waybar-dwl.sh} "$monitor"
  '';
in {
  home.packages = with pkgs;
    [
      wayland
      wayland-protocols
      wlroots_0_19
      wmenu
      wl-clipboard
      grim
      slurp
      swaybg
      inotify-tools
      jq
      wlr-randr
    ]
    ++ [
      (pkgs.dwl.override {
        configH = ./dwl-config.h;
      })
      waybar-dwl
    ];
}
