{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    opts = {
     number = true;
     relativenumber = true;

     shiftwidth = 2;

    };
    
    # Your nixvim configuration here
    #colorschemes.gruvbox.enable = true;
    plugins = {
      lualine.enable = true;
      mini.enable = true;
    };

    plugins.lsp = {
      enable = true;

      servers = {
        tsserver.enable = true;

        lua-ls = {
          enable = true;
          settings.telemetry.enable = false;
        };
        rust-analyzer = {
          enable = true;
          installCargo = true;
        };
      };
    };
  };
}

























