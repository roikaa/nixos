
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

        ciscoPacketTracer8
    
        gns3-gui
        # gns3-server
        qemu
    ];

    
    services.gns3-server = {
        enable = true;
        dynamips.enable = true;
    };
}
