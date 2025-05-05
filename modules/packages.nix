{ pkgs, ... }:
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

		# Gaming
		dolphin-emu
		heroic 
		mangohud
		prismlauncher
		steam
		vesktop

		# GUI applications
		baobab
		brave
		kdePackages.xdg-desktop-portal-kde
		kitty
		libresprite
		mpv
		nextcloud-client
		spotube
		telegram-desktop
	];

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
	};
}
