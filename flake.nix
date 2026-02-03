{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
		millennium.url = "github:trivaris/millennium?dir=packages/nix"; # Temporary fix until this is merged into main millennium repo 
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
        		url = "github:Superredstone/nixvim";
        		inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland.url = "github:hyprwm/Hyprland";
		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, nixvim, millennium, hyprland, nur, ... }@inputs: 
	let
		overlays = [
			millennium.overlays.default
			nur.overlays.default
		];
		personalEmail = "patrickcanal3@gmail.com";
		mkSystem = import ./lib/mksystem.nix {
			inherit	
				overlays
				nixvim
				millennium
				nur
				inputs
				nixpkgs
				home-manager;
		};
	in
	{
		nixosConfigurations.katana = mkSystem "katana" {
			system = "x86_64-linux";
			user = "r3ddy";
			email = personalEmail;
			gamingSystem = true;
			# Currently supported: plasma, gnome, hyprland and none
			desktopEnvironment = "gnome";
		};
		nixosConfigurations.workstation = mkSystem "workstation" {
			system = "x86_64-linux";
			user = "r3ddy";
			email = personalEmail;
			workSystem = true;
			desktopEnvironment = "gnome";
		};
		nixosConfigurations."bomba" = mkSystem "bomba" {
			system = "x86_64-linux";
			email = personalEmail;
			user = "r3ddy";
			desktopEnvironment = "none";
		};
	};
}
