{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      url = "github:NalonOff/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, spicetify-nix, nixcord, nixvim, stylix, ... }:
    let
      system = "x86_64-linux";
      settings = import ./settings.nix;

      commonHomeModules = [
        spicetify-nix.homeManagerModules.default
        nixcord.homeModules.nixcord
        nixvim.homeModules.nixvim
        stylix.homeModules.stylix
      ];

      commonExtraArgs = {
        inherit inputs settings;
        inherit spicetify-nix nixcord nixvim stylix;
      };
    in {
      nixosConfigurations.${settings.system.hostname} = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit settings; };

        modules = [
          ./hosts/nixos
          stylix.nixosModules.stylix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${settings.user.username} = import ./home;
              extraSpecialArgs = commonExtraArgs;
              sharedModules = commonHomeModules;
            };
          }
        ];
      };

      homeConfigurations.${settings.user.username} = home-manager.lib.homeManagerConfiguration {
        system = system;
        modules = [
          ./home
        ] ++ commonHomeModules;
        extraSpecialArgs = commonExtraArgs;
      };
    };
}

