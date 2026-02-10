{pkgs, lib, config, inputs, ...}:
let
  # Create JSON string of stylix colors
  stylixColors = lib.optionalString (config.stylix.enable or false) (builtins.toJSON {
    base00 = "#${config.lib.stylix.colors.base00}";
    base01 = "#${config.lib.stylix.colors.base01}";
    base02 = "#${config.lib.stylix.colors.base02}";
    base03 = "#${config.lib.stylix.colors.base03}";
    base04 = "#${config.lib.stylix.colors.base04}";
    base05 = "#${config.lib.stylix.colors.base05}";
    base06 = "#${config.lib.stylix.colors.base06}";
    base07 = "#${config.lib.stylix.colors.base07}";
    base08 = "#${config.lib.stylix.colors.base08}";
    base09 = "#${config.lib.stylix.colors.base09}";
    base0A = "#${config.lib.stylix.colors.base0A}";
    base0B = "#${config.lib.stylix.colors.base0B}";
    base0C = "#${config.lib.stylix.colors.base0C}";
    base0D = "#${config.lib.stylix.colors.base0D}";
    base0E = "#${config.lib.stylix.colors.base0E}";
    base0F = "#${config.lib.stylix.colors.base0F}";
  });
in
{
  programs.neovim = {
    enable = true;
    extraPython3Packages = ps: with ps; [
      pynvim
    ];
    extraWrapperArgs = [ 
      "--set" "STYLIX_ENABLED" "${if config.stylix.enable or false then "1" else "0"}"
    ] ++ lib.optionals (config.stylix.enable or false) [
      "--set" "STYLIX_COLORS" stylixColors
    ];
  };
  
  xdg.configFile."nvim".source = inputs.nvim-config;
  
  home.packages = with pkgs; [
    lua54Packages.luarocks-nix 
    lua5_1
    ripgrep
    fd
    tree-sitter
  ];
}
