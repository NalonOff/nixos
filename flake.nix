{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
	config.allowUnfree = true;
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
	modules = [
	  ./hosts/nixos
	  home-manager.nixosModules.home-manager
	  {
	    home-manager = {
	      useGlobalPkgs = true;
	      useUserPackages = true;
	      users.nalon = import ./home;
            };
	  }
	];
      };

      homeConfigurations.nalon = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	modules = [
	  ./home
        ];
	extraSpecialArgs = {
	  inherit inputs;
	};
      };
    };
}
