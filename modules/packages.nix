{ pkgs, gamingSystem, workSystem, currentSystemDe, ... }@ inputs:
{
	imports = [
		./programs
	];

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		# CLI utils
		appimage-run
		bat
		btop
		bun
		busybox
		distrobox
		docker
		dua
		fd
		fish
		fzf
		gh
		git
		gitlab-ci-local
		gnumake
		htop
		inotify-tools
		jq
		just
		killall
		krabby
		lazygit
		nmap
		nodejs
		openssl
		openvpn
		pinentry-tty
		python3
		ripgrep
		tree
		unzip
		wget
		wl-clipboard
		xdotool
		xorg.xwininfo
		yad
		zip
		zoxide
		zulu

		# Man pages
		man-pages

		vim  # The only and one great editor
		inputs.nixvim.packages.${stdenv.hostPlatform.system}.default # The only and one great editor improved even further 
	] ++ (if currentSystemDe != "none" then [
		# Video card
		vulkan-tools

		# GUI applications
		baobab
		bazaar
		blackbox-terminal
		firefox
		fluffychat
		gnome-boxes
		mpv
		nextcloud-client
		piper
		spotube
		telegram-desktop
		thunderbird
	] else [])
	++ (if gamingSystem then [
		cura-appimage
		discord
		heroic 
		lutris
		mangohud
		openrgb
		prismlauncher
		protonplus
		satisfactorymodmanager
	] else [])
	++ (if workSystem then [
		android-studio
		ansible
		virt-manager
	] else [])
	++ (if currentSystemDe == "plasma" then [
		kdePackages.wallpaper-engine-plugin
	] else [])
	++ (if currentSystemDe == "hyprland" then [
		# Hyprland
		brightnessctl
		hyprpaper
		pamixer
		pavucontrol
		kdePackages.dolphin
	] else [])
	++ (if currentSystemDe == "gnome" then [
		gnome-tweaks
		gnomeExtensions.appindicator
		gnomeExtensions.caffeine
		gnomeExtensions.dash-to-dock
		gnomeExtensions.wallpaper-slideshow
	] else []);

}
