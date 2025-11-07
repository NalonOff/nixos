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

      # Import your settings from settings.nix
      settings = import ./settings.nix;

      # Common Home Manager modules
      commonHomeModules = [
        spicetify-nix.homeManagerModules.default
        nixcord.homeModules.nixcord
        nixvim.homeModules.nixvim
        stylix.homeModules.stylix
      ];

      # Common extraSpecialArgs - pass all inputs AND settings
      commonExtraArgs = {
        inherit inputs settings;
        inherit spicetify-nix nixcord nixvim stylix;
      };

    in {
      nixosConfigurations.${settings.system.hostname} = nixpkgs.lib.nixosSystem {
        inherit system;

        # Pass settings to NixOS modules
        specialArgs = { inherit settings; };

        modules = [
          ./hosts/nixos
          stylix.nixosModules.stylix
          # Allow unfree packages at system level
          {
            nixpkgs.config.allowUnfree = true;
          }
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
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home
          # Allow unfree packages for standalone Home Manager config
          {
            nixpkgs.config.allowUnfree = true;
          }
        ] ++ commonHomeModules;
        extraSpecialArgs = commonExtraArgs;
      };
    };
}
