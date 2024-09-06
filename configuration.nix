{ config, pkgs, ... }:

{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		./modules/nvidia.nix
		./modules/services.nix
		./modules/styling.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.configurationLimit = 10;
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

	boot.initrd.luks.devices."luks-332a07bd-65fb-4d91-91ba-fe3f594063b1".device = "/dev/disk/by-uuid/332a07bd-65fb-4d91-91ba-fe3f594063b1";
	networking.hostName = "nixos"; # Define your hostname.

	networking.networkmanager.enable = true;
	networking.firewall.allowedUDPPorts = [ 25565 ];
	networking.firewall.allowedTCPPorts = [ 25565 ];
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

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


	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;

	programs.fish.enable = true; # This must be true before initializing my user
	users.users.r3ddy = {
		isNormalUser = true;
		description = "Patrick Canal";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;
	};

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
	];

	nixpkgs.config.allowUnfree = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	environment.systemPackages = with pkgs; [
		# CLI utils
		appimage-run
		cmake
		fish
		fzf
		gcc
		git
		gnumake
		jq
		ripgrep
		tree
		unzip
		wget
		wl-clipboard
		zip
		zoxide
		zulu

		vim  # The only and one great editor
		neovim # The only and one great editor improved even further 

		# Video card
		vulkan-tools

		# Gaming
		heroic
		mangohud
		prismlauncher
		steam
		vesktop

		# Desktop utils 
		kitty
		xdg-desktop-portal-gtk
		xdg-desktop-portal-kde

		# LSPs 
		nil # .nix
	];

	programs.steam.enable = true;
	programs.steam.remotePlay.openFirewall = true;

	system.stateVersion = "24.05"; # Did you read the comment?
}
