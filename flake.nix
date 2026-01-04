{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
	    	nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
	    	nixpkgs-stable-nixos.url = "github:nixos/nixpkgs/nixos-24.11";
	    	nixpkgs-stable-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

	    	home-manager-unstable = {
	      		url = "github:nix-community/home-manager";
	      		inputs.nixpkgs.follows = "nixpkgs-unstable";
	    	};
	    	home-manager-stable-nixos = {
	      		url = "github:nix-community/home-manager/release-24.11";
	      		inputs.nixpkgs.follows = "nixpkgs-stable-nixos";
	    	};
	    	home-manager-stable-darwin = {
	      		url = "github:nix-community/home-manager/release-24.11";
	      		inputs.nixpkgs.follows = "nixpkgs-stable-darwin";
	    	};
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
        		url = "github:Superredstone/nixvim";
        		inputs.nixpkgs.follows = "nixpkgs-unstable";
		};
		hyprland.url = "github:hyprwm/Hyprland";
		millennium = {
			url = "git+https://github.com/SteamClientHomebrew/Millennium?ref=legacy";
			inputs.nixpkgs.follows = "nixpkgs";
		};
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
				inputs;
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
