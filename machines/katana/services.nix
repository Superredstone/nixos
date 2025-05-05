{ pkgs, ... }:
{
	services.flatpak.enable = true;
	services.xserver.videoDrivers = ["nvidia"];

	services.xserver.enable = true;
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;
	services.displayManager.sddm.wayland.enable = true; 

	# services.xserver.displayManager.gdm.enable = true;
	# services.xserver.desktopManager.gnome.enable = true;
	# environment.gnome.excludePackages = (with pkgs; [
	# 	atomix # puzzle game
	# 	cheese # webcam tool
	# 	epiphany # web browser
	# 	evince # document viewer
	# 	geary # email reader
	# 	gedit # text editor
	# 	gnome-characters
	# 	gnome-music
	# 	gnome-photos
	# 	gnome-terminal
	# 	gnome-tour
	# 	hitori # sudoku game
	# 	iagno # go game
	# 	tali # poker game
	# 	totem # video player
	# ]);


	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
}
