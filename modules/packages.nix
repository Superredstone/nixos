{ pkgs, nur, gamingSystem, workSystem, currentSystemDe, ... }@ inputs:
{
	imports = [
		./nordvpn.nix
	];

	environment.systemPackages = with pkgs; [
		# CLI utils
		appimage-run
		btop
		busybox
		distrobox
		docker
		fish
		fzf
		git
		gitlab-ci-local
		gnumake
		gnupg
		htop
		inotify-tools
		jq
		just
		killall
		krabby
		nmap
		nodejs
		openssl
		openvpn
		pinentry-tty
		podman-compose
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
		firefox
		gnome-boxes
		kitty
		mpv
		piper
		telegram-desktop
	] else [])
	++ (if gamingSystem then [
		cura-appimage
		discord
		ftb-app
		heroic 
		lutris
		mangohud
		openrgb
		prismlauncher
		protonplus
		xenia-canary
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
	] else []);

	programs.gamescope = {
		enable = true;
		capSysNice = true;
	};
	programs.steam = if gamingSystem then {
		enable = true;
		# package = pkgs.steam-millennium;
		remotePlay.openFirewall = true;
	} else {};

	programs.hyprland.enable = if currentSystemDe == "hyprland" then true else false;

	programs.nh = {
		enable = true;
	};
}
