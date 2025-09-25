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
        ts_ls.enable = true;

        lua_ls = {
          enable = true;
          settings.telemetry.enable = false;
        };
        rust_analyzer = {
          enable = true;
          installCargo = true;
	  installRustc = true;
        };
      };
    };
  };
}

























