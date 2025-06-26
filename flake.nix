{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Spicetify-nix for Spotify theming
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, ... }@inputs:
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
              # Pass inputs to Home Manager
              extraSpecialArgs = {
                inherit inputs;
              };
              # Add Spicetify module to Home Manager
              sharedModules = [
                spicetify-nix.homeManagerModules.default
              ];
            };
          }
        ];
      };

      homeConfigurations.nalon = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home
          # Add Spicetify module
          spicetify-nix.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}
