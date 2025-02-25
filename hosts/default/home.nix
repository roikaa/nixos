{ config, pkgs, ... }:

{
  home.username = "akio";
  home.homeDirectory = "/home/akio";

  home.packages = [
 

  ];

  programs.git = {
    enable = true;
    userName = "roikaa";
    userEmail = "akio216216@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

   home.sessionVariables = {
     EDITOR = "nvim";
  };


  home.file = {


  };


  home.stateVersion = "24.11"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}
