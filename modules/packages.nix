{ pkgs, gamingSystem, ... }:
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
		hyprpaper
		kdePackages.xdg-desktop-portal-kde
		kitty
		mpv
		nextcloud-client
		pavucontrol
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
	] else []);

	programs.steam = if gamingSystem then {
		enable = true;
		remotePlay.openFirewall = true;
	} else {};

	programs.hyprland.enable = true;

	programs.nh = {
		enable = true;
		clean.enable = true;
	};
}
