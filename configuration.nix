{ config, pkgs, ... }:

{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.configurationLimit = 10;
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 1w";
	};

	boot.initrd.luks.devices."luks-332a07bd-65fb-4d91-91ba-fe3f594063b1".device = "/dev/disk/by-uuid/332a07bd-65fb-4d91-91ba-fe3f594063b1";
	networking.hostName = "nixos"; # Define your hostname.

	networking.networkmanager.enable = true;

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

	services.xserver.enable = true;
	services.flatpak.enable = true;
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	users.users.r3ddy = {
		isNormalUser = true;
		description = "Patrick Canal";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;
		packages = with pkgs; [
			vesktop
			kitty
			heroic
		];
	};

	programs.fish.enable = true;
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		localNetworkGameTransfers.openFirewall = true;
	};

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
	];

	nixpkgs.config.allowUnfree = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	environment.systemPackages = with pkgs; [
		git
		vim 
		neovim
		wget
		vulkan-tools
		fish
		gcc
		unzip
		zip
		ripgrep
		jq
		fzf
		gnumake
		cmake
		zoxide
		xdg-desktop-portal-gtk
		xdg-desktop-portal-kde
	];

	system.stateVersion = "24.05"; # Did you read the comment?
}
