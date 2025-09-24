{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland Window Managar
    hyprland.url = "github:hyprwm/Hyprland";

    # Styling tool
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix4nvchad = {
      url = "github:nix-community/nix4nvchad/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      system = "x86_64-linux";
      host = "kaze";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
    nixosConfigurations = { 
      ${host} = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/kaze/configuration.nix
           inputs.home-manager.nixosModules.default
           inputs.stylix.nixosModules.stylix
           #inputs.nix4nvchad.homeManagerModules.nvchad
        ];
      };
    };
  };
}
