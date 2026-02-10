{pkgs, lib, config, inputs, ...}:
{

programs.neovim = {
  enable = true;
  extraPython3Packages = ps: with ps; [
    pynvim
  ];
  extraWrapperArgs = [ "--set" "STYLIX_ENABLED" "1" ];
};   

stylix.targets.neovim.enable = true;

 # Use a different directory for your custom config
  xdg.configFile."nvim".source = inputs.nvim-config;
  
  # Then in your init.lua, require the custom config
  # programs.neovim.extraLuaConfig = ''
    # require('custom')
  # '';
  home.packages = with pkgs;[
  lua54Packages.luarocks-nix 
  lua5_1
  ripgrep
  fd
  tree-sitter
];
}
