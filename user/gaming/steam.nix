{pkgs, ..}:
{

    environment.sessionVariables = {
        GDK_SCALE = "1";
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
        "\${HOME}/.steam/root/compatibilitytools.d";
    };


    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        # remotePlay.openFirewall = true;
        # dedicatedServer.openFirewall = true;
        # localNetworkGameTransfers.openFirewall = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    home.packages = with pkgs; [
        mangohud
        protonup
    ];

    programs.gamemode.enable = true;
}
