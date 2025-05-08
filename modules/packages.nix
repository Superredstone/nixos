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
		brave
		kitty
		mpv
		nextcloud-client
		spotube
		telegram-desktop

	] ++ (if gamingSystem then [
			libresprite
			dolphin-emu
			heroic 
			mangohud
			prismlauncher
			steam
			vesktop
	] else [])
	++ (if currentSystemDe == "hyprland" then [
		# Hyprland
		brightnessctl
		hyprpaper
		pamixer
		pavucontrol
		kdePackages.dolphin
	] else []);

	programs.steam = if gamingSystem then {
		enable = true;
		remotePlay.openFirewall = true;
	} else {};

	programs.hyprland.enable = if currentSystemDe == "hyprland" then true else false;

	programs.nh = {
		enable = true;
		clean.enable = true;
	};

	xdg = {
		autostart.enable = true;
		portal = {
			enable = true;
			extraPortals = with pkgs; [
				xdg-desktop-portal-gtk
			];
		};
	};
}
