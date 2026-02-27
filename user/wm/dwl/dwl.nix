{pkgs, ...}: {
  # Adding some dependencies
  home.packages = with pkgs;
    [
      wayland
      wayland-protocols
      wlroots_0_19
      # foot
      # git
      wmenu
      wl-clipboard
      grim
      slurp
      swaybg
      # firefox
      # jetbrains-mono
    ]
    ++ [
      ((pkgs.dwl.override {
        configH = ./dwl-config.h;
      }).overrideAttrs (old: {
        patches = (old.patches or []) ++ [ ./ipc.patch ];
      }))
    ];
}
