{
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
		overlays = [];
		personalEmail = "patrickcanal3@gmail.com";
		mkSystem = import ./lib/mksystem.nix {
			inherit	
				overlays
				inputs;
		};
	in
	{
		nixosConfigurations.katana = mkSystem "katana" {
			system = "x86_64-linux";
			user = "r3ddy";
			email = personalEmail;
		};
	};
}
