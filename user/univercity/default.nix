{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # gns3-gui
    # gns3-server
    dynamips
    vpcs
    # ubridge
    libvirt

    # Python and networking tools
    python3
    python3Packages.pip
    python3Packages.netmiko

    # Useful networking tools
    busybox
    inetutils
    wireshark
    tcpdump

    #robotics
    clang-tools
    gnumake
    gdb

    #presntation
    pdfpc
  ];

  virtualisation.libvirtd.enable = true;

  # networking.bridges.br-gns3.interfaces = [];
  # networking.interfaces.br-gns3 = {
  #   ipv4.addresses = [{
  #     address = "192.168.1.10";
  #     prefixLength = 24;
  #   }];
  # };
  #
  users.users.akio.extraGroups = ["kvm" "libvirtd" "wireshark" "dialout"]; # "gns3"
  #
  # security.wrappers.ubridge = {
  #   source = "${pkgs.ubridge}/bin/ubridge";
  #   capabilities = "cap_net_admin,cap_net_raw=ep";
  #   owner = "root";
  #   group = "root";
  #   permissions = "u+rx,g+x,o+x";
  # };
}
