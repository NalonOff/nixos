{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:KaylorBen/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, spicetify-nix, nixcord, nixvim, stylix, ... }:
    let
      system = "x86_64-linux";

      # Configuration commune pour les modules Home Manager
      commonHomeModules = [
        spicetify-nix.homeManagerModules.default
        nixcord.homeModules.nixcord
        nixvim.homeManagerModules.nixvim
        stylix.homeManagerModules.stylix
      ];

      # Configuration commune pour extraSpecialArgs - passer tous les inputs
      commonExtraArgs = {
        inherit inputs;
        inherit spicetify-nix nixcord nixvim stylix;
      };

      # pkgs avec config commune
      pkgs = nixpkgs.legacyPackages.${system}.extend (final: prev: {
        config.allowUnfree = true;
      });

    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nalon = import ./home;
              extraSpecialArgs = commonExtraArgs;
              sharedModules = commonHomeModules;
            };
          }
        ];
      };

      homeConfigurations.nalon = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home ] ++ commonHomeModules;
        extraSpecialArgs = commonExtraArgs;
      };
    };
}
