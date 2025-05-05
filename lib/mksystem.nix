# This file comes from https://github.com/kahlstrm/nixos-config/blob/main/lib/mksystem.nix
{
	overlays,
	nixvim,
	inputs,
}:
name:
{
	system,
	user,
	email,
	wsl ? false,
	stable ? false,
}:
let
	# True if this is a WSL system.
	isWSL = wsl;
	# resolves NixOS vs nix-darwin and stable vs unstable functions
	inherit
		(import ./resolve-inputs.nix {
			inherit
				system
				stable
				inputs
				;
		})
		isDarwin
		lib
		systemFunc
		nixpkgs-stable
		home-manager
		;
	# The config files for this system.
	nixConfig = ../modules/nix-config/default.nix;
	machineConfig = ../machines/${name}/default.nix;
	# OSConfig = ../modules/${if isDarwin then "darwin" else "nixos"}.nix;
	HMConfig = ../home;
	# systemPackages = ../modules/packages.nix;
	# TODO: make this cleaner
	nix-homebrew = lib.optionalAttrs isDarwin inputs.nix-homebrew.darwinModules.nix-homebrew;
	nix-homebrew-config = lib.optionalAttrs isDarwin {
		nix-homebrew = {
			enable = true;
			inherit user;
			# Detect and automatically migrate existing Homebrew installations
			autoMigrate = true;
			# With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
			#mutableTaps = false;
		};
	};
	specialArgs = {
		pkgs-stable = import nixpkgs-stable {
			inherit system;
			config.allowUnfree = true;
		};
		pkgs-unstable = import inputs.nixpkgs-unstable {
			inherit system;
			config.allowUnfree = true;
		};
		currentSystem = system;
		currentSystemName = name;
		currentSystemUser = user;
		currentSystemEmail = email;
		isWSL = isWSL;
		isDarwin = isDarwin;
		inputs = inputs;
	};
in
assert isWSL -> !isDarwin;
systemFunc {
	inherit system specialArgs;
	modules = [
		{ nixpkgs.overlays = overlays; }
		{ nixpkgs.config.allowUnfree = true; }
		(if isWSL then inputs.nixos-wsl.nixosModules.wsl else { })
		nixConfig
		nix-homebrew
		nix-homebrew-config
		home-manager.home-manager
		{
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.users.${user} = import HMConfig;
			home-manager.extraSpecialArgs = specialArgs;
			home-manager.sharedModules = [
				nixvim.homeManagerModules.nixvim
			];
		}
		machineConfig
	];
}

