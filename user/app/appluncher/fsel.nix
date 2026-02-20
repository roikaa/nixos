{ inputs, ... }: {
  home.packages = [ inputs.fsel.packages.${pkgs.system}.default ];
}
