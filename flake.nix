{
	description = "My NixOS";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix.url = "github:danth/stylix";
	};

	outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix

				home-manager.nixosModules.home-manager 
				{
					home-manager.backupFileExtension = "backup";
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.r3ddy = import ./home;
				}
				stylix.nixosModules.stylix
			];
		};
	};
}
