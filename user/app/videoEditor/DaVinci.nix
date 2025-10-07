{config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
    davinci-resolve
  ];
  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
  };
}
