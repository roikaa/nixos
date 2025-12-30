{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ciscoPacketTracer8
    
    gns3-gui
    gns3-server
    dynamips
    vpcs
    ubridge

    xterm              # Classic, lightweight
    # konsole          # KDE (if using KDE)
    # gnome.gnome-terminal  # GNOME (if using GNOME)
    # alacritty        # Modern, GPU-accelerated
    
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
#   users.groups.ubridge = { }; # Explicitly defines the 'ubridge' group
  users.users.akio.extraGroups = ["kvm" "libvirtd" "wireshark"]; # "gns3" 
#
#  security.wrappers.ubridge = {
#   source = "/run/current-system/sw/bin/ubridge";
#   capabilities = "cap_net_admin,cap_net_raw+ep";
#   owner = "root";
#   group = "ubridge"; # You will need to create this group
#   # permissions = "u+rx,g+x";
#     permissions = "u+rx,g+rx,o+rx";
# }; 

  security.wrappers.ubridge = {
    source = "${pkgs.ubridge}/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "root";
    permissions = "u+rx,g+x";
  };
    
}
