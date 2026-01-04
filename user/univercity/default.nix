{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gns3-gui
    gns3-server
    dynamips
    vpcs
    # ubridge

    xterm              # Classic, lightweight
    
    # Python and networking tools
    python3
    # python3Packages.pip
    # python3Packages.netmiko
    
    # Useful networking tools
    busybox
    inetutils
    wireshark
    tcpdump
  ];

  virtualisation.libvirtd.enable = true;
#
  users.users.akio.extraGroups = ["kvm" "libvirtd" "wireshark"]; # "gns3" 

  security.wrappers.ubridge = {
    source = "${pkgs.ubridge}/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "root";
    permissions = "u+rx,g+x";
  };
    
}
