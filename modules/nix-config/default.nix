{ pkgs, ... }:
{
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 1w";
	};

	# Remove old gtkrc file, otherwise it will not work
	system.userActivationScripts = {
		removeConflictingFiles = {
			text = ''
				rm -f /home/r3ddy/.gtkrc-2.0.backup
			'';
		};
	};


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
	users.users.r3ddy = {
		isNormalUser = true;
		description = "Patrick Canal";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		shell = pkgs.fish;
	};

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
