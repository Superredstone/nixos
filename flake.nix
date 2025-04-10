{
	description = "My NixOS";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = {
        		url = "github:nix-community/nixvim";
        		inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs: 
	let 
		system = "x86_64-linux";
	in
	{
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			modules = [
				./configuration.nix

				home-manager.nixosModules.home-manager 
				{
					home-manager.backupFileExtension = "backup";
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.sharedModules = [
              					nixvim.homeManagerModules.nixvim
            				];

					home-manager.users.r3ddy = import ./home;
				}
			];
		};
	};
}
