{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Ajout de Stylix
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nalon = import ./home;
              # Passer Stylix à Home Manager
              extraSpecialArgs = {
                inherit inputs;
              };
              # Ajouter le module Stylix à Home Manager
              sharedModules = [
                stylix.homeManagerModules.stylix
              ];
            };
          }
        ];
      };

      homeConfigurations.nalon = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home
          # Ajouter le module Stylix
          stylix.homeManagerModules.stylix
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}
