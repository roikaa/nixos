{pkgs, config, lib, ...}:
{
  home.packages = with pkgs; [
    texliveFull

    typst
    typst-live
    typstfmt
  ];
}
