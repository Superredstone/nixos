{ pkgs, gamingSystem, currentSystemDe, ... }:
{
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
		gnumake
		htop
		jq
		killall
		krabby
		md2pdf
		nmap
		nodejs
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
		# neovim # The only and one great editor improved even further 

		# Video card
		vulkan-tools

		# GUI applications
		baobab
		firefox
		gnome-boxes
		kitty
		mpv
		telegram-desktop
	] ++ (if gamingSystem then [
		archipelago
		dolphin-emu
		heroic 
		libresprite
		mangohud
		openrgb
		prismlauncher
		steam
		vesktop
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

	programs.steam = if gamingSystem then {
		enable = true;
		remotePlay.openFirewall = true;
	} else {};

	programs.hyprland.enable = if currentSystemDe == "hyprland" then true else false;

	programs.nh = {
		enable = true;
	};

	xdg = {
		autostart.enable = true;
		portal = {
			enable = true;
			extraPortals = with pkgs; [
				# xdg-desktop-portal-gtk
			];
		};
	};
}
