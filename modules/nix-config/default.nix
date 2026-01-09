{ pkgs, currentSystemUser, currentSystemDe, ... }:
{
	imports = [
		./keyboard.nix
		./security.nix
	] ++ (if (currentSystemDe != "none") then [
		./sound.nix
		./fonts.nix
		./de.nix
	] else []);

	time.timeZone = "Europe/Rome";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "it_IT.UTF-8";
		LC_IDENTIFICATION = "it_IT.UTF-8";
		LC_MEASUREMENT = "it_IT.UTF-8";
		LC_MONETARY = "it_IT.UTF-8";
		LC_NAME = "it_IT.UTF-8";
		LC_NUMERIC = "it_IT.UTF-8";
		LC_PAPER = "it_IT.UTF-8";
		LC_TELEPHONE = "it_IT.UTF-8";
		LC_TIME = "it_IT.UTF-8";
	};

	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1"; # Use Wayland when possible (this does not seem to work)
		ELECTRON_OZONE_PLATFORM_HINT = "wayland";
		GOPATH = "$HOME/.go";
	};

	programs.fish.enable = true; # This must be true before initializing my user
	users.users.${currentSystemUser} = {
		isNormalUser = true;
		description = "Patrick Canal";
		extraGroups = [ "networkmanager" "wheel" "docker" "nordvpn" ];
		shell = pkgs.fish;
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.packageOverrides = pkgs: {
    		nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
      			inherit pkgs;
    		};
  	};

	documentation.man.generateCaches = false;
}
