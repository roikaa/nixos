{pkgs, ...}:

{

  environment.sessionVariables = {
    GDK_SCALE = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
      "\${HOME}/.steam/root/compatibilitytools.d";
  };

  environment.systemPackages = with pkgs; [
    mangohud
    protonup
    
  ];

  programs = {

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    gamemode = {
      enable = true; 
    };
  };
}
