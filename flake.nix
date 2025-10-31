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
      flake = false;  # It's just files, not a flake
    };

    # Styling tool
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      system = "x86_64-linux";
#      host = "kaze";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
      {
    nixosConfigurations = { 
      kaze = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/kaze/configuration.nix
           inputs.home-manager.nixosModules.default
           inputs.stylix.nixosModules.stylix
        ];
      };
      nobu = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nobu/configuration.nix
           inputs.home-manager.nixosModules.default
           inputs.stylix.nixosModules.stylix
        ];
      };

    };
  };
}
