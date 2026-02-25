{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland Window Managar
    hyprland.url = "github:hyprwm/Hyprland";

    # My Neovim configuration 
     nvim-config = {
      url = "github:roikaa/nvim";
      flake = false;
    };

    # Styling tool
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   grubshin-bootpact = {
      url = "github:max-ishere/grubshin-bootpact"; 

    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
      {
    nixosConfigurations = { 
      kaze = nixpkgs.lib.nixosSystem {
        specialArgs = {
            inherit inputs;
            inherit unstable;
          };
        modules = [
          ./hosts/kaze/configuration.nix
           inputs.home-manager.nixosModules.default
           inputs.stylix.nixosModules.stylix
        ];
      };
      nobu = nixpkgs.lib.nixosSystem {
        specialArgs = {
            inherit inputs;
            inherit unstable;
          };
        modules = [
          ./hosts/nobu/configuration.nix
           inputs.home-manager.nixosModules.default
           inputs.stylix.nixosModules.stylix
        ];
      };

    };
  };
}
