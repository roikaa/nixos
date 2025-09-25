{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    
    # Your nixvim configuration here
    #colorschemes.gruvbox.enable = true;
    #

        plugins = {
	 lualine.enable = true;
	  mini.enable = true;
   	};
  };
}
